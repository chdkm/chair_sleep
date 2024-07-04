module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],

  plugins: [
    require("daisyui"),
  ],

  daisyui: {
    themes: ["retro"],
  },

  theme: {
    extend: {
      colors: {
        customBlue: {
          DEFAULT: '#0F2D49',
        },
        customBeige: {
          DEFAULT: '#CCBF90',
        },
      },
    },
  },
}
