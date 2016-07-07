function [dx] = double_pendulum_sys(t,x,tau)

    m1 = 1;
    m2 = 1;
    l1 = 1;
    l2 = 1;
    lc1 = l1/2;
    lc2 = l2/2;
    Ic1 = (lc1*lc1)/3;
    Ic2 = (lc2*lc2)/3;
    I1 = Ic1+m1*lc1*lc1;
    I2 = Ic2+m2*lc2*lc2;
    b1 = 0.4;
    b2 = 0.4;
    g = 9.8;
    
    q = [x(1); x(3)];
    qd = [x(2); x(4)];

    H = [I1 + I2 + m2*l1^2 + 2*m2*l1*lc2*cos(q(2)), I2 + m2*l1*lc2*cos(q(2));
         I2 + m2*l1*lc2*cos(q(2)),                  I2                      ];

    C = [-2*m2*l1*lc2*sin(q(2))*qd(2) + b1, -m2*l1*lc2*sin(q(2))*qd(2);
         m2*l1*lc2*sin(q(2))*qd(1),         b2                        ];

    G = [m1*g*lc1*sin(q(1)) + m2*g*(l1*sin(q(1))+lc2*sin(q(1)+q(2)));
         m2*g*lc2*sin(q(1)+q(2))                                    ];

    B = [1;
         1];
     
    qdd = inv(H)*(B*tau - C*qd - G);
    
    dx = [qd(1); qdd(1); qd(2); qdd(2)];
    
end
