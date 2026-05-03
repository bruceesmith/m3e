package code

import (
	"generator/parser"
	"testing"
)

func Test_imports(t *testing.T) {
	type args struct {
		module *parser.Module
	}
	tests := []struct {
		name    string
		args    args
		want    string
		wantErr bool
	}{
		{
			name: "No imports",
			args: args{
				module: &parser.Module{
					Imports: map[string]string{},
				},
			},
			want:    "\n",
			wantErr: false,
		},
		{
			name: "Single import without types",
			args: args{
				module: &parser.Module{
					Imports: map[string]string{
						"gleam/int": "",
					},
				},
			},
			want:    "\nimport gleam/int\n",
			wantErr: false,
		},
		{
			name: "Single import with types",
			args: args{
				module: &parser.Module{
					Imports: map[string]string{
						"lustre/element": ".{type Element}",
					},
				},
			},
			want:    "\nimport lustre/element.{type Element}\n",
			wantErr: false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			gotBuilder, err := imports(tt.args.module)
			if (err != nil) != tt.wantErr {
				t.Errorf("imports() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			var got string
			if gotBuilder != nil {
				got = gotBuilder.String()
			}
			if got != tt.want {
				t.Errorf("imports() = %q, want %q", got, tt.want)
			}
		})
	}
}
