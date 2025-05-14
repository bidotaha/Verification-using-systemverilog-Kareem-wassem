module priority_sva (
input logic clk,
input logic rst,
input logic [3:0] D,	
input logic [1:0] Y,              
input logic valid
);
    
    property rst_check;
        @(posedge clk) (rst) |=> (Y == 2'b00);
    endproperty
    assert property (rst_check) else $error("error in rst");
    cover property (rst_check);  

    property check1;
        @(posedge clk) disable iff (rst)
            (D == 4'b1000) |=> (Y == 0);
    endproperty
    assert property (check1) else $error(" error in check1");
    cover property (check1);      

    property check2;
        @(posedge clk) disable iff (rst)
            (D [2:0] == 3'b100) |=> (Y == 1);
    endproperty
    assert property (check2) else $error(" error in check2");
    cover property (check2);      

    property check3;
        @(posedge clk) disable iff (rst)
            (D [1:0] == 2'b10) |=> (Y == 2);
    endproperty
    assert property (check3) else $error(" error in check3");
    cover property (check3);      

    property check4;
        @(posedge clk) disable iff (rst)
            (D [0] == 1'b1) |=> (Y == 3);
    endproperty
    assert property (check4) else $error(" error in check4");
    cover property (check4);    


    property valid_check;
        @(posedge clk) disable iff (rst)
            (~|D) |=> (valid == 0);
    endproperty
    assert property (valid_check) else $error(" error in valid");
    cover property (valid_check);                     

endmodule