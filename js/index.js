import d3 from './lib/d3'
import makeGame from './lib/game'

document.addEventListener('DOMContentLoaded', function () {
  d3.selectAll('.twenty48-policy-player')
    .datum(function () { return this.dataset })
    .each(function (data) {
      makeGame(
        d3.select(this),
        parseInt(data.boardSize, 10),
        parseInt(data.maxExponent, 10),
        data.packedPolicyPath,
        parseInt(data.initialSeed, 10)
      )
    })
})
