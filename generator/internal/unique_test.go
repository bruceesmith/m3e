package internal

import (
	"reflect"
	"testing"
)

// TestUnique_string tests the Unique function with string inputs.
func TestUnique_string(t *testing.T) {
	tests := []struct {
		name     string
		input    []string
		expected []string
	}{
		{"both empty", []string{}, []string{}},
		{"duplicate", []string{"a", "b", "c", "a"}, []string{"a", "b", "c"}},
		{"out of order", []string{"one", "two", "three", "four"}, []string{"four", "one", "three", "two"}},
		{"more duplicates", []string{"hello", "world", "hello", "world"}, []string{"hello", "world"}},
		// Add more test cases as needed
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := Unique(tt.input)
			if !reflect.DeepEqual(result, tt.expected) {
				t.Errorf("Unique(%v) = %v; want %v", tt.input, result, tt.expected)
			}
		})
	}
}

// TestUnique_string tests the Unique function with int inputs.
func TestUnique_int(t *testing.T) {
	tests := []struct {
		name     string
		input    []int
		expected []int
	}{
		{"both empty", []int{}, []int{}},
		{"identical", []int{1, 2, 3, 4}, []int{1, 2, 3, 4}},
		{"duplicate", []int{1, 2, 2, 3, 4}, []int{1, 2, 3, 4}},
		{"out  of order", []int{1, 2, 5, 3, 6, 4}, []int{1, 2, 3, 4, 5, 6}},
		// Add more test cases as needed
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := Unique(tt.input)
			if !reflect.DeepEqual(result, tt.expected) {
				t.Errorf("Unique(%v) = %v; want %v", tt.input, result, tt.expected)
			}
		})
	}
}
