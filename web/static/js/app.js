import {Socket} from "phoenix"

let socket = new Socket("/ws")
socket.connect()
socket.join("game:play", {}).receive("ok", chan => {
  console.log("Got into the channel.")
})


let canvas = document.getElementById("canvas")
let context = canvas.getContext("2d")

let nextFrameInitialX = 12
let nextFrameInitialY = 0

let App = {
  runTetris: function(){
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
    this.draw(context, state)
  },
  draw: function(context, state){
    this.drawBoard(context, state.board)
    this.drawNext(context, state.next)
  },
  drawBoard: function(context, board){
    this.drawFrame(context, board)
    this.drawPixelArray(context, board, 0, 0)
  },
  drawNext: function(context, next){
    this.drawNextPiece(context, next)
  },
  drawPixelArray: function(context, pixelArray, initialX, initialY){
    for(let i = 0; i < pixelArray.length; i++) {
      for(let j = 0; j < pixelArray[0].length; j++) {
        let col = pixelArray[i][j]
        switch(col){
          case 0:
            break;
          default:
            this.drawSquare(context, initialX + j, initialY + i, this.brushFor(this.shapeName(col)))
        }
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
    for(let x = 0; x <= boardWidth; x++) {
      this.drawSquare(context, x, boardHeight, brush)
    }
    for(let y = 0; y < boardHeight; y++){
      this.drawSquare(context, 0, y, brush)
      this.drawSquare(context, boardWidth, y, brush)
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

App.runTetris()

export default App
