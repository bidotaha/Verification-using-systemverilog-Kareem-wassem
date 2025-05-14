import my_package ::*;

module arrar_tb ();

screen my_screen;

 initial begin

     my_screen = new();
    assert (my_screen.randomize());
    my_screen.print_screen;

 end    
endmodule