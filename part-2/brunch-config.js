module.exports = {
  config: {
    paths: {
      watched: ["app"]
    },
    files: {
      javascripts: {
        joinTo: "js/app.js"
      },
      stylesheets: {
        joinTo: "css/app.css"
      }
    },
    plugins: {
      elmBrunch: {
        mainModules: ["app/elm/Main.elm"],
        outputFolder: "public/js/"
      },
      sass: {
        mode: "native"
      },
      autoReload: {}
    }
  }
};
