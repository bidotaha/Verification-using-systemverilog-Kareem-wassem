import my_package::*;
module tb ;
    mem_trans obj1,obj2;
    initial begin
        obj1 = new(,2);
        obj1.print ();

        obj2 = new(3,4);
        obj2.print ();


    end
endmodule