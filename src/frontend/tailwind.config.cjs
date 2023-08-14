module.exports = {
  darkMode: 'class',
  content: [__dirname + '/**/*.html', __dirname + '/**/*.jsx'],
  theme: {
    screens: {
      'xs': '320px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
    },
    extend: {
      spacing: {
        '72': '18rem',
        '84': '21rem',
        '96': '24rem',
        '128': '32rem',
      },
      fontSize: {
        'btn': '1.5rem',
        'lg': '1.125rem',
      },
      padding: {
        'btn': '1.5rem',
      },
      maxWidth: {
        'desktop': '640px',
      },
      colors: {
        text: "var(--text-color)",
        emphasize: "var(--emphasize-color)",
        bg: "var(--background-color)",
        border: "var(--border-color)",
      },
      backgroundColor: {
        main: "var(--background-color)",
        emphasize: "var(--background-emphasize-color)",
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
