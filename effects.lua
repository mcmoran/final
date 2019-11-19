chain = moonshine.chain(moonshine.effects.pixelate)
chain = chain.chain(moonshine.effects.crt)
chain = chain.chain(moonshine.effects.scanlines)
chain.crt.distortionFactor = {1.005, 1.005}
chain.scanlines.width = 1
chain.scanlines.frequency = gridYCount * cellSize / 1
chain.scanlines.color = {3,3,3}
