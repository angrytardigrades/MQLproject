import cv2, time
first_frame=None
video = cv2.VideoCapture(0)

#this is a loop that capture the frames
while True:
    check, frame = video.read()
    gray=cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
    gray=cv2.GaussianBlur(gray,(21,21),0)

    if first_frame is None:
        first_frame=gray
        continue

    delta_frame=cv2.absdiff(first_frame,gray)
    thresh_frame=cv2.threshold(delta_frame, 30,255,cv2.THRESH_BINARY)[1]
    thresh_frame=cv2.dilate(thresh_frame, None, iterations=2)

    (cnts,_) = cv2.findContours(thresh_frame.copy(),cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

#you need to play wih these parameters :) specially contourArea value for example change it to 1 or 10000000 and see the diffrence 
# for me 10000 was ok, but it should be based on your purpose and also the video source quality also can affect this parameter so tune it based on your needs
    for contour in cnts:
        if cv2.contourArea(contour) <10000:
            continue
        status=1
        (x,y,w,h)= cv2.boundingRect(contour)
        cv2.rectangle(frame,(x,y),(x+w,y+h),(0,255,0),3)

#you can comment / enable "gray","delta frame" , "thresh frame"
    #cv2.imshow("Gray Frame",gray)
    #cv2.imshow("Delta fram",delta_frame)
    #cv2.imshow("Thresh Frame",thresh_frame)    
    cv2.imshow("Color Frame",frame)


    #cv2.imshow("Capturing",gray)
    key=cv2.waitKey(1)
    if key==ord("q"):
        break

video.release()
cv2.destroyAllWindows