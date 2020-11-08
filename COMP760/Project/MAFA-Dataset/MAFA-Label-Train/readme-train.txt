MAFA training set
1) images folder puts the 25876 image files; 
2) the label is stored in LabelTrainAll.mat,
3) the format is stored in a 18d array (x,y,w,h, x1,y1,x2,y2, x3,y3,w3,h3, occ_type, occ_degree, gender, race, orientation, x4,y4,w4,h4),  where        (a) (x,y,w,h) is the bounding box of a face, 
    (b) (x1,y1,x2,y2) is the position of two eyes.
    (c) (x3,y3,w3,h3) is the bounding box of the occluder. Note that (x3,y3) is related to the face bounding box position (x,y)
    (d) occ_type stands for the occluder type and has: 1 for simple, 2 for complex and 3 for human body.
    (e) occ_degree stands for the number of occluded face parts
    (f) gender and race stand for the gender and race of one face
    (g) orientation stands for the face orientation/pose, and has: 1-left, 2-left frontal, 3-frontal, 4-right frontal, 5-right
    (h) (x4,y4,w4,h4) is the bounding box of the glasses and is set to (-1,-1,-1,-1) when no glasses.  Note that (x4,y4) is related to the face bounding box position (x,y)

If any question, please contact me. (geshiming@iie.ac.cn)