CCISample {

	var server;
	var busOut;
	var syns;
	var params;
	var bufs;

	*new {
		arg serverName,argBusOut;
		^super.new.init(serverName,argBusOut);
	}

	init {
		arg serverName,argBusOut;

		// set arguments
		server=serverName;
		busOut=argBusOut;

		syns=Dictionary.new();
		bufs=Dictionary.new();
		params=Dictionary.new();

		(1..2).do({arg ch;
			SynthDef("defPlay"++ch,{
				arg db=6.neg,fade=0.2,loop=0,out,buf,t_free=0;

				var snd;

				snd=PlayBuf.ar(
					numChannels:ch,
					bufnum:buf,
					loop:loop,
					doneAction:2
				);

				// fade in
				snd=snd*EnvGen.ar(Env.new([0,1],fade));

				// fade out
				snd=snd*EnvGen.ar(Env.new([1,0],fade),t_free,doneAction:2);

				// volume level
				snd=snd*Lag.kr(db).dbamp;

				Out.ar(out,snd);
			}).send(server);
		});

		server.sync;
	}


	stop {
		arg id,fade;
		if (syns.at(id).notNil,{
			if (syns.at(id).isRunning,{
				["stop",id].postln;
				syns.at(id).set(\fade,fade,\t_free,1);
			});
		});
	}

	play {
		arg id,fade,loop;
		this.stop(id,0.2);
		["play",id].postln;
		if (bufs.at(id).notNil,{
			var pars=[\buf,id,\fade,fade,\loop,loop];
			params.at(id).keysValuesDo({ arg pk,pv; 
				pars=pars++[pk,pv];
			});
			syns.put(id,Synth.new("defPlay"++bufs.at(id).numChannels,pars).onFree({["freed"+id].postln}));
			NodeWatcher.register(syns.at(id));
		},{
			Buffer.read(server,id,action:{arg buf;
				bufs.put(id,buf);
				params.put(id,Dictionary.new());
				syns.put(id,Synth.new("defPlay"++bufs.at(id).numChannels,
					[\buf,id,\fade,fade,\loop,loop]
				).onFree({["freed"+id].postln}));
				NodeWatcher.register(syns.at(id));
			});
		});
	}


	set {
		arg id,key,val;
		["set",id,key,val].postln;
		if (params.at(id).isNil,{
			params.put(id,Dictionary.new());
		});
		params.at(id).put(key,val);
		if (syns.at(id).notNil,{
			if (syns.at(id).isRunning,{
				syns.at(id).set(key,val);
			});
		});
	}


	free {
		syns.keysValuesDo({ arg note, val;
			val.free;
		});
		bufs.keysValuesDo({ arg buf, val;
			val.free;
		});
		params.free;
		bufs.free;
		syns.free;
	}

}
