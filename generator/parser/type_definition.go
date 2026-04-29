package parser

import (
	"fmt"
	"os"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_typescript "github.com/tree-sitter/tree-sitter-typescript/bindings/go"
)

type walker struct {
	code   []byte
	cursor *tree_sitter.TreeCursor
	types  []tsTypeDef
}

type tsTypeDef struct {
	Name   string
	Values []string
}

func typeDefinitions(fileName string, identifier string, buf []tsTypeDef) (types []tsTypeDef, err error) {
	var code []byte

	buf = buf[:0]
	code, err = os.ReadFile(fileName)
	if err != nil {
		return nil, fmt.Errorf("unable to read %s: %w", fileName, err)
	}

	parser := tree_sitter.NewParser()
	defer parser.Close()
	parser.SetLanguage(tree_sitter.NewLanguage(tree_sitter_typescript.LanguageTypescript()))

	tree := parser.Parse(code, nil)
	defer tree.Close()

	w := &walker{code: code, cursor: tree.RootNode().Walk(), types: buf}
	defer w.cursor.Close()

	err = w.walk(tree.RootNode(), fileName, identifier, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to walk the syntax tree: %w", err)
	}
	return w.types, nil
}

func (w *walker) walk(n *tree_sitter.Node, fileName string, typeName string, td *tsTypeDef) (err error) {
	for _, node := range n.Children(w.cursor) {
		err = w.handleNode(node, fileName, typeName, td)
		if err != nil {
			return fmt.Errorf("failed to handle a syntax node: %w", err)
		}
	}
	return
}

func (w *walker) handleNode(node tree_sitter.Node, fileName string, typeName string, td *tsTypeDef) (err error) {
	kind := node.Kind()
	start, end := node.ByteRange()

	switch kind {
	case "export_statement":
		if td == nil {
			td = &tsTypeDef{Values: make([]string, 0, 30)}
		}
		err = w.walk(&node, fileName, typeName, td)
		if err != nil {
			return fmt.Errorf("failed to handle an export_statement node: %w", err)
		}
	case "literal_type":
		td.Values = append(td.Values, string(w.code[start:end]))
	case "type", "type_alias_declaration", "type_definition", "union_type":
		err = w.walk(&node, fileName, typeName, td)
		if err != nil {
			return fmt.Errorf("failed to handle a %s node: %w", kind, err)
		}
	case "type_identifier":
		td.Name = string(w.code[start:end])
	case ";":
		w.types = append(w.types, *td)
		td = &tsTypeDef{}
	}
	return
}
