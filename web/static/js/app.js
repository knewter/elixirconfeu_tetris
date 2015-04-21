import {Socket} from "phoenix"


let canvas = document.getElementById("canvas")
let context = canvas.getContext("2d")

let nextFrameInitialX = 14
let nextFrameInitialY = 0

let socket = new Socket("/ws")
socket.connect()
socket.join("game:play", {}).receive("ok", chan => {
  console.log("Got into the channel.")
  chan.on("tetris:state", payload => {
    console.log(payload)
    App.draw(context, payload)
  })

  function gameEventFor(evt){
    let key = evt.keyIdentifier || evt.key
    switch(key){
      case "Left":
      case "ArrowLeft":
        return "move_left"
      case "Right":
      case "ArrowRight":
        return "move_right"
      case "Up":
      case "ArrowUp":
        return "rotate_cw"
      default:
        console.log(key)
        return "noop"
    }

  }

  window.onkeyup = function(e){
    e.preventDefault()
    chan.push("event", { event: gameEventFor(e) })
  }
})

let App = {
  draw: function(context, state){
    this.drawBoard(context, state.board)
    this.drawNext(context, state.next)
  },
  drawBoard: function(context, board){
    this.drawFrame(context, board)
    this.drawPixelArray(context, board, 1, 0)
  },
  drawNext: function(context, next){
    this.drawNextPiece(context, next)
  },
  drawPixelArray: function(context, pixelArray, initialX, initialY){
    for(let i = 0; i < pixelArray.length; i++) {
      for(let j = 0; j < pixelArray[0].length; j++) {
        let col = pixelArray[i][j]
        let brush;
        switch(col){
          case 0:
            brush = this.brushFor("background")
            break;
          default:
            brush = this.brushFor(this.shapeName(col))
        }
        this.drawSquare(context, initialX + j, initialY + i, brush)
      }
    }
  },
  drawNextPiece: function(context, next){
    this.drawPixelArray(context, next, nextFrameInitialX, nextFrameInitialY)
  },
  drawFrame: function(context, board){
    let brush = this.brushFor("board")
    let boardWidth = board[0].length
    let boardHeight = board.length
    for(let x = 0; x <= boardWidth+1; x++) {
      this.drawSquare(context, x, boardHeight, brush)
    }
    for(let y = 0; y < boardHeight; y++){
      this.drawSquare(context, 0, y, brush)
      this.drawSquare(context, boardWidth+1, y, brush)
    }
  },
  drawSquare: function(context, x, y, brush){
    let side = 25
    let trueX = side * x
    let trueY = side * y
    context.fillStyle = brush
    context.fillRect(trueX, trueY, side, side)
  },
  brushFor: function(type){
    switch(type){
      case "board":
        return "rgb(0,0,0)"
      case "background":
        return "rgb(255, 255, 255)"
      case "ell":
        return "rgb(255, 150, 0)"
      case "jay":
        return "rgb(12, 0, 255)"
      case "ess":
        return "rgb(5, 231, 5)"
      case "zee":
        return "rgb(255, 17, 17)"
      case "bar":
        return "rgb(0, 240, 255)"
      case "oh":
        return "rgb(247, 255, 17)"
      case "tee":
        return "rgb(100, 255, 17)"
    }
  },
  shapeName: function(num){
    switch(num){
      case 1:
        return("ell");
      case 2:
        return("jay");
      case 3:
        return("ess");
      case 4:
        return("zee");
      case 5:
        return("bar");
      case 6:
        return("oh");
      case 7:
        return("tee");
    }
  }
}

let state = {
  board: [
    [0,0,0,0,1,0,0,0,0,0],
    [0,0,0,0,1,0,0,0,0,0],
    [0,0,0,0,1,1,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0]
  ],
  next: [
    [1, 0],
    [1, 0],
    [1, 1]
  ]
}
//App.draw(context, state)

export default App
