package internal

import (
	"bufio"
	"bytes"
	"fmt"
	"io/fs"
	"log/slog"
	"os"
	"path/filepath"
	"strings"
)

// GrepLR mimics: grep -r -l pattern m3eSource
func GrepLR(m3eSource, pattern string) (foundIn string, err error) {
	target := []byte(pattern)

	// Open the base folder securely as an os.Root filesystem
	root, err := os.OpenRoot(m3eSource)
	if err != nil {
		return "", fmt.Errorf("failed to open root path: %w", err)
	}
	defer func() {
		if err := root.Close(); err != nil {
			slog.Error("failed to closed root filesystem", "root", m3eSource, "error", err)
		}
	}()

	// Walk the folder structure looking for a file that contains the pattern
	err = fs.WalkDir(root.FS(), ".", func(path string, d fs.DirEntry, err error) error {
		// Early exit (initial Stat on the root directory failed, a directory's ReadDir method failed)
		if err != nil {
			return err
		}

		// Skip directories and target TypeScript files specifically
		if d.IsDir() {
			return nil
		}
		ext := strings.ToLower(filepath.Ext(path))
		if ext != ".ts" && ext != ".tsx" {
			return nil
		}

		// Open the file relative to the secure root handle
		matched, err := hasPattern(root, path, target)
		if err != nil {
			return nil // Safely skip unreadable files if needed
		}

		if matched {
			foundIn = path
			// We have found an occurrence of the pattern
			return fs.SkipAll
		}
		return nil
	})

	return foundIn, err
}

// hasPattern searches for a pattern in a single file
func hasPattern(root *os.Root, relPath string, target []byte) (bool, error) {
	// Open files securely inside the sandbox bounds
	file, err := root.Open(relPath)
	if err != nil {
		return false, err
	}
	defer func() {
		if err := file.Close(); err != nil {
			slog.Error("failed to close file", "file", relPath, "error", err)
		}
	}()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		// Stop executing immediately on the first match (-l short-circuiting)
		if bytes.Contains(scanner.Bytes(), target) {
			return true, nil
		}
	}
	return false, scanner.Err()
}
