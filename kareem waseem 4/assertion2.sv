module assertion2 ( input logic clk,request,grant,frame,irdy
);
    property prop1;
    @(posedge clk) $rose (request) |=> ##[2:5] grant;
    endproperty
    label1 : assert property (prop1);
    label2 : cover property (prop1);

    property prop2;
    @(posedge clk) $rose (grant) |-> ($fell(frame) && $fell(irdy));
    endproperty   
    label3 : assert property (prop2);
    label4 : cover property (prop2);    

    property prop3;
    @(posedge clk) ($rose (frame) && $rose (irdy)) |=> $fell(grant);
    endproperty 
    label5 : assert property (prop3);
    label6 : cover property (prop3);

endmodule