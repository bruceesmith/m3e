package internal

import (
	"cmp"
	"slices"
)

// Unique takes a slice and returns a new sorted slice containing only the unique elements
func Unique[T cmp.Ordered](input []T) []T {
	// seen tracks items we've already added
	seen := make(map[T]struct{})
	result := []T{}
	for _, val := range input {
		// If the key is not in the map, it's a new unique element
		if _, ok := seen[val]; !ok {
			seen[val] = struct{}{}
			result = append(result, val)
		}
	}
	slices.Sort(result)
	return result
}
