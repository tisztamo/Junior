#!/bin/sh
set -e
goal="Fix TypeScript compilation issues"
echo "Plan:"
echo "1. Change the 'target' value in tsconfig.json to a valid TypeScript version."
echo "2. Update the 'lib' values in tsconfig.json to supported libraries."

# Step 1: Update the 'target' value
cat > integrations/vscode/tsconfig.json << 'EOF'
{
	"compilerOptions": {
		"module": "commonjs",
		"target": "es2018",
		"outDir": "out",
		"lib": [
			"es2018", "dom"
		],
		"sourceMap": true,
		"rootDir": "src",
		"strict": true
	}
}
EOF

echo "\033[32mDone: $goal\033[0m\n"