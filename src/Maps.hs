module Maps where

import Data.HashMap
import Diagrams.Prelude

default (Double)

data MapSpec = Pts [(Double, Double)] | Trl (Trail V2 Double)

maps :: Map String MapSpec
maps = fromList [   ("triang", triang),
                    ("square", sq),
                    ("rect", rectang),
                    ("star",four_star),
                    ("pent",pent),
                    ("pent_y",pent_scaley),
                    ("pent_shear",pent_shear),
                    ("hex", hex),
                    ("hep", hep),
                    ("oct", oct),
                    ("nine", nine),
                    ("bigc", big_convex),
                    ("circ",circ),
                    ("irrsquare",irrsquare),
                    ("isos", isoscelestri),
                    ("thintriangle", thintriangle),
                    ("thintriangle2", thintriangle2),
                    ("poly1", poly1),
                    ("poly2", poly2),
                    ("poly3", poly3),
                    ("tworooms", tworooms),
                    ("tworooms2", tworooms2),
                    ("bigpoly", bigpoly)
                ]

--  can either specify concrete points, or use diagrams shape primitives
--  http://projects.haskell.org/diagrams/haddock/Diagrams-TwoD-Shapes.html
triang = Trl $ triangle 500
sq = Trl $ square 500
rectang = Trl $ rect 250 500
pent = Trl $ regPoly 5 500
pent_scaley = Trl $ regPoly 5 500 # scaleY 2
pent_shear = Trl $ regPoly 5 500 # shearX 0.4
hex = Trl $ regPoly 6 500
hep = Trl $ regPoly 7 500
oct = Trl $ regPoly 8 500
oct_shear = Trl $ regPoly 8 500 # shearX 0.4
nine = Trl $ regPoly 9 500
big_convex = Pts [(450,150),(650,420),(425,500),(200,480),(50,270),(170,80),(300,50)]
circ = Trl $ circle 500
four_star = Pts [(150,150),(0,500),(-150,150),(-500,0),(-150,-150),(0,-500),(150,-150),(500,0)]
irrsquare = Pts [(-400,0),(0,-100),(400,0),(10,100)]
isoscelestri = Pts [(700,-250),(0,250),(-700,-250)]
thintriangle = Pts [(-100,0),(0,-1),(100,0)]
thintriangle2 = Pts [(0,-1),(100,0),(0,1)]
poly1 = Pts [(200,-100), (210,50), (100,200), (0,150), (-50,200), (-150,100), (-200,10), (-140,-30), (-220, -200), (100, -180), (150,50)]
poly2 = Pts [(200,-100), (210,50), (100,200), (0,150), (-50,200), (-150,100), (-200,10), (-140,-30), (-220, -200), (-150, -200), (-50,-5), (80,-5), (100, -180), (150,50)]
poly3 = Pts [(200,-100), (210,50), (100,200), (0,150), (-50,200), (-150,100), (-200,10), (-140,-30), (-220, -200), (100, -200), (-100, -100), (-50,-5), (80,-5), (100, -180), (150,50)]
tworooms = Pts [(-250,-250), (-10,-250), (-10,240), (10,240), (10,-250), (250,-250), (250, 250), (-250, 250)]
tworooms2 = Pts [(-250,-250), (-50,-250), (-50,240), (50,240), (50,-250), (250,-250), (250, 250), (-250, 250)]
bigpoly = Pts [(10.284109,990.061662), (10.284109,950.174263), (170.174960,970.184987), (260.484751,960.648794), (100.112360,910.420912), (60.741573,930.833780), (00.321027,910.018767), (10.605136,750.469169), (30.531300,800.294906), (40.173355,890.812332), (110.075441,840.718499), (170.977528,870.399464), (290.855538,730.592493), (520.166934,800.563003), (450.906902,810.367292), (320.263242,760.943700), (260.805778,850.656836), (380.844302,950.308311), (400.449438,900.482574), (340.670947,860.193029), (380.041734,820.975871), (460.227929,920.091153), (470.993579,950.576408), (530.772071,880.471850), (450.104334,840.986595), (580.105939,810.233244), (570.303371,750.603217), (510.685393,770.077748), (550.216693,700.643432), (480.314607,750.335121), (490.277689,670.560322), (440.301766,750.469169), (400.288925,650.549598), (340.831461,710.447721), (260.645265,680.498660), (170.656501,800.831099), (70.704655,810.903485), (30.531300,710.045576), (110.396469,570.908847), (190.743178,600.723861), (100.272873,730.324397), (130.162119,740.798928), (210.669342,660.756032), (210.508828,570.506702), (240.719101,550.764075), (130.001605,550.630027), (180.619583,500.938338), (80.346709,550.093834), (120.520064,470.453083), (50.136437,560.300268), (60.260032,630.538874), (10.605136,620.466488), (70.865169,470.721180), (30.852327,470.721180), (30.049759,540.289544), (00.000000,520.949062), (20.247191,430.833780), (70.223114,430.833780), (80.346709,400.080429), (10.605136,410.286863), (00.963082,370.131367), (20.407705,360.193029), (30.370787,390.410188), (80.667737,370.667560), (70.544141,340.182306), (50.296950,350.388740), (50.778491,380.069705), (40.173355,380.203753), (30.210273,330.378016), (10.123596,330.378016), (00.642055,300.965147), (60.420546,300.831099), (100.112360,340.450402), (150.730337,310.501340), (110.075441,290.758713), (100.433387,320.171582), (70.544141,270.882038), (00.481541,270.613941), (60.741573,260.005362), (40.012841,210.849866), (00.481541,210.715818), (50.457464,180.364611), (00.000000,160.353887), (70.383628,140.477212), (00.160514,110.796247), (80.507223,100.321716), (40.654896,80.445040), (10.444623,100.857909), (00.000000,70.104558), (110.396469,40.825737), (110.235955,90.249330), (140.767255,60.970509), (180.780096,40.155496), (120.199037,20.144772), (410.733547,00.000000), (460.869984,170.292225), (330.547352,160.756032), (340.991974,100.991957), (400.609952,130.538874), (370.239165,60.434316), (190.422151,60.702413), (100.914928,150.013405), (140.446228,280.686327), (180.940610,260.407507), (140.767255,180.096515), (220.311396,100.187668), (290.373997,90.383378), (320.423756,190.705094), (240.719101,210.715818), (270.447833,260.005362), (390.165329,190.034853), (450.264848,270.211796), (350.152488,320.171582), (310.460674,400.348525), (320.744783,430.297587), (200.224719,310.769437), (120.520064,360.193029), (120.199037,420.761394), (180.940610,430.565684), (320.102729,550.898123), (300.016051,600.187668), (360.597111,600.723861), (380.362761,550.227882), (310.621188,490.329759), (240.879615,430.833780), (160.372392,400.348525), (170.335474,350.924933), (230.756019,360.461126), (280.410915,410.554960), (280.892456,440.772118), (310.621188,450.844504), (380.683788,390.544236), (480.314607,320.707775), (470.351525,240.798928), (560.019262,240.128686), (540.414125,160.621984), (470.993579,80.847185), (600.995185,20.144772), (730.033708,20.144772), (940.221509,20.680965), (980.555377,110.528150), (970.592295,220.386059), (870.800963,200.777480), (870.961477,120.466488), (820.664526,70.372654), (730.515249,80.579088), (610.155698,60.702413), (600.192616,210.983914), (710.749599,210.313673), (660.773676,140.611260), (820.504013,110.662198), (850.874799,150.951743), (780.170144,160.353887), (790.133226,240.530831), (960.468700,250.201072), (830.788122,270.479893), (770.849117,280.686327), (870.640449,300.697051), (890.887640,350.254692), (850.714286,390.142091), (830.627608,330.378016), (710.910112,300.965147), (750.601926,220.788204), (690.983949,240.128686), (660.131621,300.160858), (610.476726,250.737265), (540.093098,290.624665), (540.253612,360.327078), (390.325843,450.174263), (590.069021,410.018767), (450.585875,500.000000), (590.229535,440.101877), (590.390048,500.134048), (530.451043,470.587131), (560.982343,520.680965), (490.277689,520.144772), (520.969502,560.032172), (510.845907,600.053619), (420.857143,500.536193), (440.141252,610.528150), (530.290530,610.528150), (650.971108,430.297587), (580.426966,360.997319), (790.454254,360.997319), (710.428571,400.348525), (760.243981,430.029491), (680.860353,470.319035), (730.515249,560.166220), (840.269663,520.278820), (790.775281,470.587131), (750.120385,520.815013), (730.996790,480.659517), (820.022472,440.504021), (870.800963,500.000000), (930.900482,470.453083), (820.182986,410.420912), (880.924559,420.627346), (930.258427,380.605898), (930.418941,300.563003), (890.887640,280.686327), (980.073836,270.747989), (960.308186,330.780161), (990.197432,330.780161), (990.036918,390.008043), (990.197432,510.206434), (960.629213,540.021448), (950.024077,580.713137), (910.653291,550.227882), (880.121990,590.249330), (860.998395,540.423592), (810.861958,600.187668), (780.491172,560.836461), (770.528090,640.343164), (650.489567,650.415550), (700.626003,620.198391), (670.094703,560.434316), (600.995185,670.560322), (630.242376,810.769437), (790.454254,800.965147), (790.775281,790.088472), (640.526485,770.882038), (670.415730,670.560322), (740.638844,700.241287), (820.022472,630.002681), (960.950241,610.528150), (1000.000000,730.726542), (920.295345,740.396783), (890.085072,690.705094), (840.911717,820.573727), (950.345104,830.914209), (950.987159,990.597855), (910.974318,880.471850), (900.690209,990.597855), (890.085072,880.337802), (860.356340,940.369973), (880.924559,990.463807), (860.035313,990.463807), (830.627608,920.761394), (840.911717,870.265416), (810.059390,870.265416), (800.577849,1000.000000), (770.849117,880.069705), (750.120385,990.463807), (730.515249,900.214477), (720.391653,990.597855), (650.008026,990.597855), (670.255217,960.648794), (670.736758,910.554960), (730.354735,860.327078), (660.613162,850.388740), (620.118780,920.359249), (610.958266,990.061662), (510.043339,990.329759)] 
