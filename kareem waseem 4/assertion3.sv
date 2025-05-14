module assertion2 ( input logic [0:1] cs,
                    input logic clk,get_data
);
    parameter IDLE = 2'b00;
    parameter WAITO = 2'b01;
    parameter GEN_BLK_ADDR = 2'b11;

    property prop_cs;
    @(posedge clk) $onehot(cs);
    endproperty
    label1 : assert property (prop_cs);
    label2 : cover property (prop_cs);

    property prop;
    @(posedge clk) (cs == IDLE && get_data) |=> (cs == GEN_BLK_ADDR) ##64 (cs == WAITO);
    endproperty   
    label3 : assert property (prop);
    label4 : cover property (prop);    


endmodule