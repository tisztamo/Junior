import tailwindcss from 'tailwindcss';
import autoprefixer from 'autoprefixer';

export default function postCssConfig() {
  return {
    plugins: [
      tailwindcss(),
      autoprefixer()
    ]
  }
}
