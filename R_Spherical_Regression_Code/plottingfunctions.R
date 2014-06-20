library("rgl")
library('png')
library('heplots')

CLOUD<-function(cloudfile){
  # Plots a alphamap image over the globe
  radius=.98
  rgl.spheres(0,0,0,radius,lit=T,color='white', textype="alpha",texture=cloudfile,back='fill')
}

POINTS3<-function(x,y,z,col='red',s=3){
  #plot points with 3D Markers
  spheres3d(x,y,z,color=col,radius=s/100, alpha= c(1.0),lit= TRUE, ambient= "black",
            specular     = "white", 
            emission     = "black", 
            shininess    = 50.0, 
            smooth       = TRUE,
            texture      = NULL, 
            textype      = "rgb", 
            texmipmap    = FALSE, 
            texminfilter = "linear", 
            texmagfilter = "linear",
            texenvmap    = FALSE,
            front        = "fill", 
            back         = "fill",
            lwd          = 1.0,
            fog          = TRUE,
            point_antialias = FALSE,
            line_antialias = FALSE,
            depth_mask   = TRUE,
            depth_test   = "less")
}
POINTS2<-function(x,y,z,col='red',s=10){  
  #plot points with 2D Markers
  points3d(x,y,z,color=col,size=s)
}
PLOT<-function(p,col='red',s=3){  
  #plot points with 2D Markers
  POINTS3(p[1,],p[2,],p[3,],col=col,s=s)
}


VIEW<-function(p=matrix(c(1,1,1))/sqrt(3),scale=1.5){
  p=matrix(p)
  p[p==0]=.01
  p=p/sqrt(sum(p*p))
  p0=matrix(c(p[1],p[2],0))
  if (p[3]==1) {
    A0=diag(3)
    A1=diag(3)
    A2=diag(3)
  } else {
    A0=rotMat(matrix(c(0,0,1)),matrix(c(0,1,0)))
    A1=rotMat(p0,matrix(c(0,-1,0)))# Rotate xy coordinates to (1,0,0)
    A2=rotMat(p,p0)# Rotate xy coordinates to (1,0,0)
  }  
  um=diag(4)
  um[1:3,1:3]=scale*A0%*%A1%*%A2
  rgl.viewpoint(fov = 0)
  par3d(userMatrix=um)
}

MESH<-function(Gamma,imagefile=0,wire=1,cloud=0){
  d=dim(Gamma)
  gamma<-t(matrix(Gamma,ncol=3))  
  A=rotMat(matrix(c(0,0,1)),matrix(c(1,0,0)))%*%rotMat(matrix(c(1,0,0)),matrix(c(0,1,0)))
  gam_A<-A%*%gamma;
  Gam_A<-array(t(gam_A), dim = c(d[1],d[2],3))# Distorted grid
  y=Gam_A[,,1]
  x=Gam_A[,,2]
  z=Gam_A[,,3]
  if (imagefile!=0){
    
    img <- readPNG(imagefile)
    dp=dim(img)
    ind1=1:dp[1]
    ind2=c(floor(dp[2]/2+1):dp[2],1:floor(dp[2]/2))
    img2=img[ind1,ind2,]
    writePNG(img2,'tmp.png')
    if (cloud==0){
      rgl.surface(.99*x,.99*y,.99*z,lit=F, texture='tmp.png',back='fill',texmagfilter='nearest')
    } else {      
      rgl.surface(.99*x,.99*y,.99*z,lit=T,color='white', textype="alpha",texture=cloudfile,back='fill')
    }      
  }
}
  if (wire) {rgl.surface(x,y,z,lit=F, color='gray90',front='line',back='line',line_antialias=TRUE,lwd=2.0,)}
  if (imagefile==0){
    rgl.surface(x,y,z,lit=T, color='gray70',specular="black")    
    
  }
}

vfield_sphere<-function(p,v,col="red",w=3){
  dp=dim(p);dv=dim(v)
  if (dp[2]==1) {
    for (i in 1:dv[2]){    
      arrow3d(p,p+v[,i],col=col,lwd=w,s=.1,n=2)
    }
  }
  if (dp[2]>1) {
    for (i in 1:dv[2]){    
      #lines3d(c(p[1,i],p[1,i]+v[1,i]),c(p[2,i],p[2,i]+v[2,i]),c(p[3,i],p[3,i]+v[3,i]),col=col,lwd=w)
      #vec=v[,i]
      arrow3d(p[,i],p[,i]+v[,i],col=col,lwd=w,s=.1,n=2)
    }
  }
}

geodesic_sphere<-function(p,v,col="blue",w=3){
  dp=dim(p);dv=dim(v)
  t=seq(0,1,length.out =100)
  if (dp[2]==1) {
    for (i in 1:dv[2]) {    
      alpha=EXP_sd(matrix(p,c(3,1)),v[,i]%*%matrix(t,c(1,100)))
      lines3d(alpha[1,],alpha[2,],alpha[3,],col=col,lwd=w)
    }
  }
  if (dp[2]>1) {
    for (i in 1:dv[2]) {    
      alpha=EXP_sd(matrix(p[,i],c(3,1)),v[,i]%*%matrix(t,c(1,100)))
      lines3d(alpha[1,],alpha[2,],alpha[3,],col=col,lwd=w)
    }
  }
}