module.exports = {
  darkMode: 'class',
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
      spacing: {
        '72': '18rem',
        '84': '21rem',
        '96': '24rem',
        '128': '32rem',
      },
      fontSize: {
        'btn': '1.5rem',
      },
      padding: {
        'btn': '1.5rem',
      },
      maxWidth: {
        'desktop': '640px',
      },
      colors: {
        light: {
          text: '#1a202c',
          background: '#f7fafc',
          emphasize: '#e2e8f0', // New color for emphasizing a component
        },
        dark: {
          text: '#f7fafc',
          background: '#1a202c',
          emphasize: '#2d3748', // New color for emphasizing a component in dark mode
        },
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
