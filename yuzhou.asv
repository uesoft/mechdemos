        % 单位圆(半径或许可能是一千亿光年)上均匀分布六个单位质量的物体
        display( '  序号 离开中心的距离 引力的和')
        m=100
         for ia=0:50,
            a=ia/(m+0.0e0) % 距离中心的距离
            n=3
            s=0
            for i=1-n:n,
                x=cos((n-i)*3.1415926535897932384626d0/3.0e0)
                % y**2=1-x**2, 六个单位质量的物体之一的坐标是x,y
                % r=sqrt(a*a+1+2*a*x) % =sqrt((a+x)**2+y**2)
                % cos((seta)=(-a-x)/r
                ss=(-a-x)/sqrt((a*a+1+2*a*x)^3) % =(1/r**2)*cos((seta)
                s=s+ss % 引力主要看增加减少，所以没有考虑引力的单位
                %write(*,'(i5,3f10.5)') i,x,s,ss
                
            sprintf('%d %g %g\n',ia,a,s)
            end
         end
         syms a,i,n,s
         s=symsum('1/(2*a*sin(pi/n*i))^2',i,1,n-1)
         

