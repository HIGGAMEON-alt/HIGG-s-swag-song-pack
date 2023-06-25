			case 'wocky':
			{
					defaultCamZoom = 0.9;
					curStage = 'stage';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);

					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;

					add(stageCurtains);
					
					phillyCityLights = new FlxTypedGroup<FlxSprite>();
					add(phillyCityLights);

					for (i in 0...4)
					{
							var light:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('philly/win' + i));
							light.scrollFactor.set(0.9, 0.9);
							light.visible = false;
							light.updateHitbox();
							light.antialiasing = true;
							phillyCityLights.add(light);
					
					}
					// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

			}
			case 'beathoven':
			{
					defaultCamZoom = 0.9;
					curStage = 'stage';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);

					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;

					add(stageCurtains);
					
					phillyCityLights = new FlxTypedGroup<FlxSprite>();
					add(phillyCityLights);

					for (i in 0...4)
					{
							var light:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('philly/win' + i));
							light.scrollFactor.set(0.9, 0.9);
							light.visible = false;
							light.updateHitbox();
							light.antialiasing = true;
							phillyCityLights.add(light);
					
					}
					// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

					littleGuys = new FlxSprite(25, 200);
		                	 littleGuys.frames = Paths.getSparrowAtlas('christmas/littleguys');
		                	  littleGuys.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
		                	  littleGuys.antialiasing = true;
	                        	 littleGuys.scrollFactor.set(0.9, 0.9);
 					littleGuys.setGraphicSize(Std.int(littleGuys.width * 1));
		                 	littleGuys.updateHitbox();
		               	 	 add(littleGuys);

			}
			case 'milf' | 'satin-panties' | 'high':
			{
					curStage = 'limo';
					defaultCamZoom = 0.90;

					var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('limo/limoSunset'));
					skyBG.scrollFactor.set(0.1, 0.1);
					add(skyBG);

					var bgLimo:FlxSprite = new FlxSprite(-200, 480);
					bgLimo.frames = Paths.getSparrowAtlas('limo/bgLimo');
					bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
					bgLimo.animation.play('drive');
					bgLimo.scrollFactor.set(0.4, 0.4);
					add(bgLimo);

					grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
					add(grpLimoDancers);

					for (i in 0...5)
					{
							var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
							dancer.scrollFactor.set(0.4, 0.4);
							grpLimoDancers.add(dancer);
					}

					var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('limo/limoOverlay'));
					overlayShit.alpha = 0.5;
					// add(overlayShit);

					// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

					// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

					// overlayShit.shader = shaderBullshit;

					var limoTex = Paths.getSparrowAtlas('limo/limoDrive');

					limo = new FlxSprite(-120, 550);
					limo.frames = limoTex;
					limo.animation.addByPrefix('drive', "Limo stage", 24);
					limo.animation.play('drive');
					limo.antialiasing = true;

					fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('limo/fastCarLol'));
					// add(limo);
			}
			case 'nyaw':
			{
					curStage = 'stageclosed';

					defaultCamZoom = 0.9;
					curStage = 'stage';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('closed'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					bottomBoppers = new FlxSprite(-600, -200);
		                	 bottomBoppers.frames = Paths.getSparrowAtlas('christmas/bgFreaks');
		                	  bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
		                	  bottomBoppers.antialiasing = true;
	                        	  bottomBoppers.scrollFactor.set(0.92, 0.92);
 						bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
		                 	 bottomBoppers.updateHitbox();
		               	 	  add(bottomBoppers);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);

					phillyCityLights = new FlxTypedGroup<FlxSprite>();
					add(phillyCityLights);

					for (i in 0...4)
					{
							var light:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('philly/win' + i));
							light.scrollFactor.set(0.9, 0.9);
							light.visible = false;
							light.updateHitbox();
							light.antialiasing = true;
							phillyCityLights.add(light);
					
					}
					// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

				upperBoppers = new FlxSprite(-600, -200);
		                  upperBoppers.frames = Paths.getSparrowAtlas('christmas/upperBop');
		                  upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
		                  upperBoppers.antialiasing = true;
		                  upperBoppers.scrollFactor.set(1.05, 1.05);
		                  upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 1));
		                  upperBoppers.updateHitbox();
		                  add(upperBoppers);
 				
				
			}
			case 'hairball':
			{

					defaultCamZoom = 0.9;
					curStage = 'stage';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('sunset'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);

					phillyCityLights = new FlxTypedGroup<FlxSprite>();
					add(phillyCityLights);

					for (i in 0...4)
					{
							var light:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('philly/win' + i));
							light.scrollFactor.set(0.9, 0.9);
							light.visible = false;
							light.updateHitbox();
							light.antialiasing = true;
							phillyCityLights.add(light);
					
					}
					// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

					upperBoppers = new FlxSprite(-600, -200);
					upperBoppers.frames = Paths.getSparrowAtlas('christmas/upperBop');
		                  upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
		                  upperBoppers.antialiasing = true;
		                  upperBoppers.scrollFactor.set(1.05, 1.05);
		                  upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 1));
		                  upperBoppers.updateHitbox();
		                  add(upperBoppers);
 					
					littleGuys = new FlxSprite(25, 200);
		                	 littleGuys.frames = Paths.getSparrowAtlas('christmas/littleguys');
		                	  littleGuys.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
		                	  littleGuys.antialiasing = true;
	                        	 littleGuys.scrollFactor.set(0.9, 0.9);
 					littleGuys.setGraphicSize(Std.int(littleGuys.width * 1));
		                 	littleGuys.updateHitbox();
		               	 	  add(littleGuys);