import Graphics.Gloss

main :: IO ()
main    
 = display 
        (InWindow "spiro"     -- window title
        (700, 600)            -- window size
        (300, 150))           -- window position
    white   -- background color
    spiro   -- picture to display

-- parameters
pointSize = 1
density = 2000
innerRadius = 15
outerRadius = 65
distance = 100
-- speed1 = 1
-- speed2 = 1.5

spiro :: Picture
spiro = line (drawHypotrochoid (0, 0) 0)

drawHypotrochoid :: Point -> Float -> Path
drawHypotrochoid (lpx, lpy) angle
    | angle >= 4000 = []
    | otherwise = (newX, newY) : drawHypotrochoid (newX, newY) (angle + step)
    where
        newX = (outerRadius - innerRadius) * (cos $ toRad angle) + distance * (cos (((outerRadius - innerRadius) / innerRadius) * (toRad angle)))
        newY = (outerRadius - innerRadius) * (sin $ toRad angle) - distance * (sin (((outerRadius - innerRadius) / innerRadius) * (toRad angle)))
        step = 360 / density

toRad :: Float -> Float
toRad angle = angle * pi / 180

-- mixed angle color1 color2 = mixColors angle (360 - angle1) color1 color2

-- colors
cerise = light $ light $ makeColorI 255 7 79 255
darkblue = light $ light $ makeColorI 0 0 153 255
