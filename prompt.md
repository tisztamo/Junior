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

src/frontend/components/ThemeSwitcher.jsx:
```
import { createEffect, createSignal } from 'solid-js';

const ThemeSwitcher = () => {
  const [theme, setTheme] = createSignal(window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');

  createEffect(() => {
    const currentTheme = theme();
    document.body.className = currentTheme;
    localStorage.setItem('theme', currentTheme);
  });

  const toggleTheme = () => {
    setTheme(theme() === 'dark' ? 'light' : 'dark');
  };

  return (
    <button onClick={toggleTheme} class="text-xl underline cursor-pointer">
      {theme() === 'dark' ? 'Light Mode' : 'Dark Mode'}
    </button>
  );
};

export default ThemeSwitcher;

```


# Task

Fix the following issue!

The theme switcher switches classes on the body, but nothing happens on the screen.


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

