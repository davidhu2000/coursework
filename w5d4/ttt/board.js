const Piece = require('./piece.js');

class Board {
  constructor(x, y) {
    this.grid = _grid(x, y);
    this.winLength = 3;
  }

  print(){
    for (let i = 0; i < this.grid.length; i++){
      console.log(this.grid[i].map( (x) => {
        if (typeof x === "undefined"){
          return " a ";
        }
        else {
          return x.toString();
        }}).join(" | "));
    }
  }

  gameOver() {
    if ((this.checkRow("white") || this.checkCol("white") || this.checkDiagonal("white")) ||
      (this.checkRow("black") || this.checkCol("black") || this.checkDiagonal("black"))) {
        return true;
      } else return false;
  }

  checkRow(color) {
    for(let i = 0; i < this.grid.length; i++) {
      // let count = this.grid[i].filter( x => x instanceof Piece).length;

      let count = this.grid[i].reduce( function(total, x) {
        return (x instanceof Piece && x.color === color) ? total + 1 : total;
      }, 0);

      if (count === this.winLength) {
        return true;
      }
    }
    return false;
  }

  checkCol(color) {
    let temp = new Board(3, 3);
    temp.grid = this.transpose();
    return temp.checkRow(color);
  }

  checkDiagonal(color) {
    let count = 0;
    let count1 = 0;
    for (let i = 0; i < this.grid.length; i++) {
      if (this.grid[i][i] instanceof Piece && this.grid[i][i].color === color)
        count += 1;
      let diagSpot = this.grid[this.grid.length-i-1][i];
      if (diagSpot instanceof Piece && diagSpot.color === color)
        count1 += 1;
    }
    if (count === 3 || count1 === 3) {
      return true;
    } else {
      return false;
    }
  }

  transpose() {
    let newGrid = this.grid.slice(0);
    newGrid = newGrid[0].map(function(col, i) {
      return newGrid.map(function(row) {
        return row[i];
      });
    });
    return newGrid;
  }

  placePiece(rowIdx, colIdx, color) {
    this.grid[rowIdx][colIdx] = new Piece(color);
  }

}

let _grid = function(row, col){
  let grid = [];
  for (let i = 0; i < row; i++) {
    let thisRow = Array.apply(null, new Array(col)).map( () => ' ');
    grid.push(thisRow);
  }
  return grid;
};

// let board = new Board(3, 3);
//
// board.grid[0][0] = new Piece('black');
// board.grid[1][1] = new Piece('black');
// board.grid[2][0] = new Piece('white');
// board.grid[2][2] = new Piece('black');
// board.print();
// console.log(board.gameOver());

module.exports = Board;
