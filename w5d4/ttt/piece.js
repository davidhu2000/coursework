class Piece {
  constructor(color) {
    this.color = color;
  }

  toString() {
    return this.color === 'black' ? 'B' : 'W';
  }
}

module.exports = Piece;
