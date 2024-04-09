module Data_Memory(clk,rst,WE,WD,A,RD);

		input clk,rst,WE;
		input [15:0]A;
		output [255:0]RD,WD;

		reg [15:0] mem [1023:0];
		wire [31:0] B, C, D, E, F, G, H, I, J, K, L, M, N, O, P;
		
		assign B = A+1;
		assign C = A+2;
		assign D = A+3;
		assign E = A+4;
		assign F = A+5;
		assign G = A+6;
		assign H = A+7;
		assign I = A+8;
		assign J = A+9;
		assign K = A+10;
		assign L = A+11;
		assign M = A+12;
		assign N = A+13;
		assign O = A+14;
		assign P = A+15;

		always @ (posedge clk)
			begin
			if(WE)
				mem[A] <= WD[15:0];
				mem[B] <= WD[31:16];
				mem[C] <= WD[47:32];
				mem[D] <= WD[63:48];
				mem[E] <= WD[79:64];
				mem[F] <= WD[95:80];
				mem[G] <= WD[111:96];
				mem[H] <= WD[127:112];
				mem[I] <= WD[143:128];
				mem[J] <= WD[159:144];
				mem[K] <= WD[175:160];
				mem[L] <= WD[191:176];
				mem[M] <= WD[207:192];
				mem[N] <= WD[223:208];
				mem[O] <= WD[239:224];
				mem[P] <= WD[255:240];
				
			end

		assign RD = (~rst) ? 32'd0 : {mem[A], mem[B], mem[C], mem[D], mem[E], mem[F], mem[G], mem[H], mem[I], mem[J], mem[K], mem[L], mem[M], mem[N], mem[O], mem[P]};

		initial begin
		mem[0] = 16'd24;
		//mem[40] = 32'h00000002;
		end


endmodule