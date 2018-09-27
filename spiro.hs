import Graphics.Gloss

main :: IO ()
main    
 = display 
        (InWindow "spiro"     -- window title
        (800, 600)            -- window size
        (300, 150))           -- window position
    black   -- background color
    spiro   -- picture to display

-- parameters
pointSize = 160.0
density = 50
radius = 100

spiro :: Picture
spiro = pictures $ drawCircle radius

drawCircle :: Float -> [Picture]
drawCircle radius = drawCircleH radius 0

drawCircleH :: Float -> Float -> [Picture]
drawCircleH radius angle
    | angle >= 360.0 = []
    | otherwise      = (translate x y $ color mixed $ Circle pointSize) : (drawCircleH radius (angle + step))
        where 
            x = radius * (cos $ toRad angle)
            y = radius * (sin $ toRad angle)
            step = 360 / density
            mixed = mixColors angle (360 - angle) cerise darkblue

toRad :: Float -> Float
toRad angle = angle * pi / 180

-- colors
cerise = light $ light $ makeColorI 255 7 79 255
darkblue = light $ light $ makeColorI 0 0 153 255
