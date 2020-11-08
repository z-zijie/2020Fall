MAFA testing set
1) images folder puts the 4935 image files; 
2) the label is stored in LabelTestAll.mat,
3) the format is stored in a 18d array (x,y,w,h,face_type,x1,y1,w1,h1, occ_type, occ_degree, gender, race, orientation, x2,y2,w2,h2),  where              (a) (x,y,w,h) is the bounding box of a face, 
    (b) face_type stands for the face type and has: 1 for masked face, 2 for unmasked face and 3 for invalid face.
    (c) (x1,y1,w1,h1) is the bounding box of the occluder. Note that (x1,y1) is related to the face bounding box position (x,y)
    (d) occ_type stands for the occluder type and has: 1 for simple, 2 for complex and 3 for human body.
    (e) occ_degree stands for the number of occluded face parts
    (f) gender and race stand for the gender and race of one face
    (g) orientation stands for the face orientation/pose, and has: 1-left, 2-left frontal, 3-frontal, 4-right frontal, 5-right
    (h) (x2,y2,w2,h2) is the bounding box of the glasses and is set to (-1,-1,-1,-1) when no glasses.  Note that (x2,y2) is related to the face bounding box position (x,y)

If any question, please contact me. (geshiming@iie.ac.cn)