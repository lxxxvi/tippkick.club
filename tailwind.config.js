module.exports = {
  purge: [
    "./app/**/*.html.haml",
    "./app/components/*.html.haml",
    "./app/components/*.rb",
    "./app/javascript/styles/**/*.css"
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      fontSize: {
        "2xs": ".625rem"
      }
    },
  },
  variants: {
    extend: {
      backgroundColor: ['checked'],
      borderColor: ['checked']
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
