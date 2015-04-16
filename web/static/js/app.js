import {Socket} from "phoenix"

// let socket = new Socket("/ws")
// socket.connect()
// socket.join("topic:subtopic", {}).receive("ok", chan => {
// })

let canvas = document.getElementById("canvas")
let context = canvas.getContext("2d")

let App = {
  runTetris: function(){
    let state = {
      board: [],
      next: "piece"
    }
    this.draw(context, state)
  },
  draw: function(context, state){
    console.log("loldraw")
  }
}

App.runTetris();

export default App
