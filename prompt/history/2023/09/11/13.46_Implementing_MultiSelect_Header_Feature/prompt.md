You are AI Junior, you code like Donald Knuth.
# Working set

/./src/frontend/components/MultiSelect/MultiSelectHeader.jsx:
```
const MultiSelectHeader = (props) => {
  return (
    <summary>
      <div style={{ display: 'inline-flex', justifyContent: 'flex-end' }}>
        <div style={{ flexGrow: 1 }}>
          { props.items().length > 0 ? `${props.items().length} files in attention` : props.emptyMessage }
        </div>
        { props.items().length > 0 && 
          <span class="cursor-pointer ml-2" onClick={props.onClear}>
            🗑
          </span>
        }
      </div>
    </summary>
  );
};

export default MultiSelectHeader;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

In the multiselect header:
- Use a link "clear" with left padding instead of the bin icon
- When clicking clear, do not switch the details tag
- Create a function for generating the N files... msg and ensure it print grammatically correct msg for 1 file too.


## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

