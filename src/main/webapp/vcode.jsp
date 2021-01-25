<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	import="java.awt.*,java.io.*,java.awt.image.*,com.sun.image.codec.jpeg.*,javax.imageio.*"%>
<%
/*
使用方法：在需要显示验证码的html代码中使用<img p">
  在需判断session的时候判断session.getAttribute("vcode")
*/
try{
  int codeLength=4;//验证码长度
  int mixTimes=0;//模糊程度参数
  Color bgColor=getRandColor(200, 250);//背景颜色
  Color bfColor=new Color(0,0,0);//字体颜色
  boolean ifRandomColor=true;//单个字符是否颜色随机
  boolean ifMixColor=true;//模糊线是否颜色随机

  //设置页面不缓存
  response.setHeader("Pragma", "No-cache");
  response.setHeader("Cache-Control", "no-cache");
  response.setDateHeader("Expires", 0);
  // 在内存中创建图象
  int width = 13*codeLength+6, height = 25;
  BufferedImage image = new BufferedImage(width, height,BufferedImage.TYPE_INT_RGB);
  // 获取图形上下文
  Graphics g = image.getGraphics();
  // 设定背景色
  g.setColor(bgColor);
  g.fillRect(0, 0, width, height);
  //设定字体
  g.setFont(new Font("Times New Roman", Font.PLAIN, 20));
  //画边框
  g.setColor(new Color(33,66,99));
  g.drawRect(0,0,width-1,height-1);
  // 随机产生干扰线，使图象中的认证码不易被其它程序探测到
  g.setColor(getRandColor(160, 200));
  for (int i = 0; i < mixTimes*codeLength/10; i++) {
 if(ifMixColor)
 {
  g.setColor(getRandColor(160, 200));
 }
 int x = random.nextInt(width);
    int y = random.nextInt(height);
    int xl = random.nextInt(12);
    int yl = random.nextInt(12);
    g.drawLine(x, y, x + xl, y + yl);
  }
  // 取随机产生的认证码(4位数字)
  String sRand = "";
  for (int i = 0; i < codeLength; i++) {
    String rand = String.valueOf(random.nextInt(10));
    sRand += rand;
    // 将认证码显示到图象中
 if(ifRandomColor)
  g.setColor(getRandColor(20,110,0)); 
 else
  g.setColor(bfColor);
 //调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成
    g.drawString(rand, 13 * i + 6, 16);
  }
  // 将认证码存入SESSION
  session.setAttribute("vcode", sRand);
  // 图象生效
  g.dispose();
  // 输出图象到页面
  OutputStream toClient = response.getOutputStream();
  ImageIO.write(image, "PNG", toClient);
         JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(toClient);

        encoder.encode(image);
  		toClient.close();
        out.clear();
		out = pageContext.pushBody();
  
  }catch(Exception e){
  	e.printStackTrace();
  }
%>
<%!//给定范围获得随机颜色
	private static Random random = new Random();

	private Color getRandColor(int fc, int bc) {
		return getRandColor(fc, bc, fc);
	}

	private Color getRandColor(int fc, int bc, int interval) {
		if (fc > 255) {
			fc = 255;
		}
		if (bc > 255) {
			bc = 255;
		}
		int r = fc + random.nextInt(bc - interval);
		int g = fc + random.nextInt(bc - interval);
		int b = fc + random.nextInt(bc - interval);
		return new Color(r, g, b);
	}%>
