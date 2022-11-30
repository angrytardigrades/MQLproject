# the lovely library than to whoever build this library
import cv2
#remember to put the below xml file in a correct path
face_cascade = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")

#you can read single img or create a loop to run through multiple image , resize them etc ... detect face whatever..
img = cv2.imread("photo2.jpg")
#use resize if require , you can also have a separate scrip before starting face detection to resize and make all images ready for you
img_resize=cv2.resize(img,(int(img.shape[1]/8),int(img.shape[0]/8)))
gray_img=cv2.cvtColor(img_resize,cv2.COLOR_BGR2GRAY)
cv2.imwrite("Image_resized.jpg",gray_img)


#you need to play with below parameters to tune it for your purpose for example if scaleFactor 1.5 couldnt detect face properly then decrease it to 1.1 or 1.05 etc 
faces= face_cascade.detectMultiScale(gray_img,
scaleFactor= 1.05,
minNeighbors=5
)
#this is for rectangle
for x,y,w,h in faces:
    img_resize=cv2.rectangle(img_resize,(x,y),(x+w,y+h),(0,255,0),3)


cv2.imshow("Gray",img_resize)
cv2.waitKey(0)
cv2.destroyAllWindows()