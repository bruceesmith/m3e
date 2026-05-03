package internal

import (
	"container/list"
	"errors"
	"fmt"
	"log/slog"
	"strings"
)

// ErrorAttr converts a series of wrapped (with %w) error messages into a slog.Attr for
// use with either the standard [log/slog] package or the [github.com/bruceesmith/logger] package
func ErrorAttr(err error) slog.Attr {
	stack := list.New()
	count := 0

	// Build a list (the"stack") of the wrapped parts of the incoming error
	// Front of the list will be the newest/outermost error
	// Back of the list will be the first / innermost error
	// Count is the number of layers in the stack of errors
	current := err
	remaining := err.Error()
	for {
		current = errors.Unwrap(current)
		count++
		if current == nil {
			stack.PushBack(remaining)
			break
		}
		front := strings.TrimSuffix(remaining, current.Error())
		stack.PushBack(front)
		remaining = current.Error()
	}

	// Build a slice of slog.Attrs, first element is the newest/outermost,
	// last element is the oldest/innermost
	element := stack.Front()
	result := make([]slog.Attr, 0, count*2)
	for {
		result = append(result, slog.String(fmt.Sprint(count), element.Value.(string)))
		count--
		element = element.Next()
		if element == nil {
			break
		}
	}

	return slog.GroupAttrs("err", result...)
}
