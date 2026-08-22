package code

import (
	_ "embed"
	"generator/parser"
	"testing"
)

func Test_slots(t *testing.T) {
	type args struct {
		theSlots []parser.Slot
	}
	tests := []struct {
		name    string
		args    args
		wantDef string
		wantFn  string
		wantErr bool
	}{
		{
			name: "No slots",
			args: args{
				theSlots: []parser.Slot{},
			},
			wantDef: "",
			wantFn:  "",
			wantErr: false,
		},
		{
			name: "One slot",
			args: args{
				theSlots: []parser.Slot{
					{
						CamelName:   "Icon",
						KebabName:   "icon",
						Description: "The icon",
						Attribute:   "icon",
					},
				},
			},
			wantDef: "\n\n/// Slots are used in child elements to insert content into this component\n///\npub type Slot {\n Icon\n // The icon\n}\n",
			wantFn:  "\n/// slot returns a Lustre Attribute(msg) for the given slot name\n///\npub fn slot(s: Slot) -> Attribute(msg) {\n case s {\n   Icon -> attribute.attribute(\"slot\", \"icon\")\n }\n}\n",
			wantErr: false,
		},
		{
			name: "Multiple slots",
			args: args{
				theSlots: []parser.Slot{
					{CamelName: "Left", KebabName: "left", Description: "Left side", Attribute: "left"},
					{CamelName: "Right", KebabName: "right", Description: "Right side", Attribute: "right"},
				},
			},
			wantDef: "\n\n/// Slots are used in child elements to insert content into this component\n///\npub type Slot {\n Left\n // Left side\n Right\n // Right side\n}\n",
			wantFn:  "\n/// slot returns a Lustre Attribute(msg) for the given slot name\n///\npub fn slot(s: Slot) -> Attribute(msg) {\n case s {\n   Left -> attribute.attribute(\"slot\", \"left\")\n   Right -> attribute.attribute(\"slot\", \"right\")\n }\n}\n",
			wantErr: false,
		},
		{
			name: "Empty name slot ignored",
			args: args{
				theSlots: []parser.Slot{
					{CamelName: "", KebabName: "", Description: "Ignored", Attribute: "ignored"},
					{CamelName: "Valid", KebabName: "valid", Description: "Keep", Attribute: "valid"},
				},
			},
			wantDef: "\n\n/// Slots are used in child elements to insert content into this component\n///\npub type Slot {\n Valid\n // Keep\n}\n",
			wantFn:  "\n/// slot returns a Lustre Attribute(msg) for the given slot name\n///\npub fn slot(s: Slot) -> Attribute(msg) {\n case s {\n   Valid -> attribute.attribute(\"slot\", \"valid\")\n }\n}\n",
			wantErr: false,
		},
		{
			name: "No description",
			args: args{
				theSlots: []parser.Slot{
					{CamelName: "NoDesc", KebabName: "no-desc", Description: "", Attribute: "no-desc"},
				},
			},
			wantDef: "\n\n/// Slots are used in child elements to insert content into this component\n///\npub type Slot {\n NoDesc\n}\n",
			wantFn:  "\n/// slot returns a Lustre Attribute(msg) for the given slot name\n///\npub fn slot(s: Slot) -> Attribute(msg) {\n case s {\n   NoDesc -> attribute.attribute(\"slot\", \"no-desc\")\n }\n}\n",
			wantErr: false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			gotDefBuilder, gotFnBuilder, err := slots(tt.args.theSlots)
			if (err != nil) != tt.wantErr {
				t.Errorf("slots() error = %v, wantErr %v", err, tt.wantErr)
				return
			}

			gotDef := ""
			if gotDefBuilder != nil {
				gotDef = gotDefBuilder.String()
			}
			if gotDef != tt.wantDef {
				t.Errorf("slots() gotDef = %q, want %q", gotDef, tt.wantDef)
			}

			gotFn := ""
			if gotFnBuilder != nil {
				gotFn = gotFnBuilder.String()
			}
			if gotFn != tt.wantFn {
				t.Errorf("slots() gotFn = %q, want %q", gotFn, tt.wantFn)
			}
		})
	}
}
