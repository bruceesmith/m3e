package parser

import "strings"

// Pre-defined mapping for performance
var digitNames = [10]string{
	"Zero", "One", "Two", "Three", "Four",
	"Five", "Six", "Seven", "Eight", "Nine",
}

// MapDigits converts numeric digits to English names
func MapDigits(s string, buf []string) string {
	buf = buf[:0]
	for i := 0; i < len(s); i++ {
		if s[i] >= '0' && s[i] <= '9' {
			// Convert byte to integer index
			idx := s[i] - '0'
			buf = append(buf, digitNames[idx])
		} else {
			buf = append(buf, string(s[i]))
		}
	}
	return strings.Join(buf, "")
}
