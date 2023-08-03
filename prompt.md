# Working set

src/frontend/tailwind.config.cjs:
```
module.exports = {
  content: [__dirname + '/**/*.html', __dirname + '/**/*.jsx'],
  theme: {
    screens: {
      'xs': '320px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
      '2xl': '1536px',
    },
    extend: {
      // Extend the spacing for larger gaps
      spacing: {
        '72': '18rem',
        '84': '21rem',
        '96': '24rem',
        '128': '32rem',
      },
      // Extend the button styles for larger buttons
      fontSize: {
        'btn': '1.5rem',
      },
      padding: {
        'btn': '1.5rem',
      },
      // Extend the maxWidth for desktop container
      maxWidth: {
        'desktop': '640px',
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}

```

src/frontend/components/NavBar.jsx:
```
import { createSignal } from 'solid-js';

const NavBar = () => {
  const title = 'Junior';

  return (
    <div>
      <h1 class="text-center text-3xl mt-6">{title}</h1>
      <a href="https://github.com/tisztamo/Junior" class="text-center text-xl underline cursor-pointer">Your AI contributor</a>
    </div>
  );
};

export default NavBar;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create a theme switcher component (default from the OS, or dark if not available) Put it to the top right of the navbar.



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

