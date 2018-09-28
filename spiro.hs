import Graphics.Gloss

main :: IO ()
main    
 = display 
        (InWindow "spiro"     -- window title
        (600, 500)            -- window size
        (300, 150))           -- window position
    black   -- background color
    spiro   -- picture to display

-- parameters
pointSize = 1
density = 2000
innerRadius = 1
outerRadius = 112
distance = 100
loops = 2

spiro :: Picture
spiro = pictures
    [ color darkRed $ line (drawEpitrochoid (0, 0) 0)
    , color rosee $ line (drawHypocycloid (0, 0) 0)
    , color lightGreen $ line (drawEpicycloid (0, 0) 0)
    , color darkblue $ line (drawHypotrochoid (0, 0) 0)
    ]

toRad :: Float -> Float
toRad angle = angle * pi / 180

-- mixed angle color1 color2 = mixColors angle (360 - angle1) color1 color2

-- colors
cerise = light $ makeColorI 255 7 79 255
purple = light $ light $ makeColorI 0 0 153 255
citrone = makeColorI 255 232 0 255
lightGreen = makeColorI 0 153 153 255
skin = makeColorI 255 204 153 255
darkblue = makeColorI 0 80 221 255
rosee = makeColorI 255 102 153 255
babyBlue = makeColorI 115 254 255 255
darkRed = makeColorI 153 0 36 255
darkPurple = makeColorI 38 0 77 255

drawHypotrochoid :: Point -> Float -> Path
drawHypotrochoid (lpx, lpy) angle
    | angle >= 360 * loops = []
    | otherwise = (newX, newY) : drawHypotrochoid (newX, newY) (angle + step)
    where
        newX = (outerRadius - innerRadius) * (cos $ toRad angle) + distance * (cos (((outerRadius - innerRadius) / innerRadius) * (toRad angle)))
        newY = (outerRadius - innerRadius) * (sin $ toRad angle) - distance * (sin (((outerRadius - innerRadius) / innerRadius) * (toRad angle)))
        step = 360 / density

drawEpicycloid :: Point -> Float -> Path
drawEpicycloid (lpx, lpy) angle
    | angle >=  360 * loops= []
    | otherwise = (newX, newY) : drawEpicycloid (newX, newY) (angle + step)
    where
        newX = (outerRadius + innerRadius) * (cos $ toRad angle) - innerRadius * (cos (((outerRadius + innerRadius) / innerRadius) * (toRad angle)))
        newY = (outerRadius + innerRadius) * (sin $ toRad angle) - innerRadius * (sin (((outerRadius + innerRadius) / innerRadius) * (toRad angle)))
        step = 360 / density

drawHypocycloid :: Point -> Float -> Path
drawHypocycloid (lpx, lpy) angle
    | angle >= 360 * loops = []
    | otherwise = (newX, newY) : drawHypocycloid (newX, newY) (angle + step)
    where
        newX = (outerRadius - innerRadius) * (cos $ toRad angle) + innerRadius * (cos (((outerRadius - innerRadius) / innerRadius) * (toRad angle)))
        newY = (outerRadius - innerRadius) * (sin $ toRad angle) - innerRadius * (sin (((outerRadius - innerRadius) / innerRadius) * (toRad angle)))
        step = 360 / density

drawEpitrochoid :: Point -> Float -> Path
drawEpitrochoid (lpx, lpy) angle
    | angle >= 360 * loops = []
    | otherwise = (newX, newY) : drawEpitrochoid (newX, newY) (angle + step)
    where
        newX = (outerRadius + innerRadius) * (cos $ toRad angle) + distance * (cos (((outerRadius + innerRadius) / innerRadius) * (toRad angle)))
        newY = (outerRadius + innerRadius) * (sin $ toRad angle) - distance * (sin (((outerRadius + innerRadius) / innerRadius) * (toRad angle)))
        step = 360 / density
