const Board = require('./board.js');
const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

class Game {
  constructor(player1, player2) {
    this.board = new Board(3, 3);
    this.player1 = player1;
    this.player2 = player2;
    this.currentPlayer = player2;
  }

  switchTurn(){
    this.currentPlayer = this.currentPlayer === this.player1 ? this.player2 : this.player1;
  }

  makeMove(rowI, colI) {
    if (this.board.grid[rowI][colI].constructor.name !== 'Piece' ){
      if (this.currentPlayer === this.player1) {
        this.board.placePiece(rowI, colI, 'white');
      } else {
        this.board.placePiece(rowI, colI, 'black');
      }
    }
  }

  getInput() {
    reader.question("What row coordinate do you want? ", rowIdx => {
      const rowI = parseInt(rowIdx);
      reader.question("What col coordinate do you want? ", colIdx => {
        const colI = parseInt(colIdx);
        this.switchTurn();
        this.makeMove(rowI, colI);
        this.play();
      });
    });
  }

  play() {
    this.board.print();
    if (this.board.gameOver()) {
      console.log(`${this.currentPlayer} won!`);
      reader.close();
    } else {
      this.getInput(this.makeMove.bind(this));
    }
  }
}

let game = new Game('p1', 'p2');
game.play();
