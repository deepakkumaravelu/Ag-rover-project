PROGRAM _INIT
	LeftWheel_F.Enable := TRUE;
	LeftWheel_F.MpLink := ADR(gAxis_1);
	LeftWheel_F.Parameters := ADR(AxisParameters);
	
	LeftWheel_B.Enable := TRUE;
	LeftWheel_B.MpLink := ADR(gAxis_2);
	LeftWheel_B.Parameters := ADR(AxisParameters);
	
	RightWheel_F.Enable := TRUE;
	RightWheel_F.MpLink := ADR(gAxis_3);
	RightWheel_F.Parameters := ADR(AxisParameters);
	
	RightWheel_B.Enable := TRUE;
	RightWheel_B.MpLink := ADR(gAxis_4);
	RightWheel_B.Parameters := ADR(AxisParameters);
	MpAlarmXHistory_0.Export :=FALSE;
END_PROGRAM

PROGRAM _CYCLIC	
	totallane;

	
	IF Start = TRUE AND Counter<>totallane THEN
		
		/////////////////////////////////////////////////////////////////////////////Robot Turning////////////////////////////////////////////////////////////////////////////////////////////////
		IF Proximity_1 = 1 AND NOT State THEN
			Counter := Counter+1;
			Pump := TRUE;
			Row := Counter MOD 2;
			IF Row=0 THEN
				RowCheckL:=TRUE;
				RowCheckR:=FALSE;
			ELSE
				RowCheckL:=FALSE;
				RowCheckR:=TRUE;
			END_IF
		ELSE
			TOF_0.IN := Proximity_1;
			Pump := FALSE;
			TOF_0.PT := T#5s;
			
		END_IF
		
		///////////////////////////////////////////////////////////////////Left Turning///////////////////////////////////////////////////////////////////////////////////////////////////////////
		IF Proximity_1 = 0 AND Row = 0 AND TOF_0.Q = TRUE THEN
			Pump := TRUE;
			IF LeftWheel_F.IsHomed = TRUE THEN
				LeftWheel_F.MoveVelocity := FALSE;
			END_IF
			IF LeftWheel_B.IsHomed = TRUE THEN
				LeftWheel_B.MoveVelocity := FALSE;
			END_IF
			IF RightWheel_F.IsHomed = TRUE THEN
				RightWheel_F.MoveVelocity := TRUE;
			END_IF
			IF RightWheel_B.IsHomed = TRUE THEN
				RightWheel_B.MoveVelocity := TRUE;
			END_IF

			////////////////////////////////////////////////////////////////////Right Turning////////////////////////////////////////////////////////////////////////////////////////////////
		ELSIF Proximity_1 = 0 AND Row = 1 AND TOF_0.Q = TRUE THEN
			Pump := TRUE;
			IF RightWheel_F.IsHomed = TRUE THEN
				RightWheel_F.MoveVelocity := FALSE;
			END_IF
			IF RightWheel_B.IsHomed = TRUE THEN
				RightWheel_B.MoveVelocity := FALSE;
			END_IF
			IF LeftWheel_F.IsHomed = TRUE THEN
				LeftWheel_F.MoveVelocity := TRUE;
			END_IF
			IF LeftWheel_B.IsHomed = TRUE THEN
				LeftWheel_B.MoveVelocity := TRUE;
			END_IF
	ELSIF Proximity_1 = 0 AND Row = 0 THEN
		IF LeftWheel_F.Info.ReadyToPowerOn = TRUE THEN
			LeftWheel_F.Power := TRUE;
			IF LeftWheel_F.PowerOn = TRUE THEN
				LeftWheel_F.Home := TRUE;
				IF LeftWheel_F.IsHomed = TRUE THEN
					LeftWheel_F.MoveVelocity := TRUE;
				END_IF
			END_IF
		END_IF
		IF LeftWheel_B.Info.ReadyToPowerOn = TRUE THEN
			LeftWheel_B.Power := TRUE;
			IF LeftWheel_B.PowerOn = TRUE THEN
				LeftWheel_B.Home := TRUE;
				IF LeftWheel_B.IsHomed = TRUE THEN
					LeftWheel_B.MoveVelocity := TRUE;
				END_IF
			END_IF
		END_IF
		
		IF RightWheel_F.Info.ReadyToPowerOn = TRUE THEN
			RightWheel_F.Power := TRUE;
			IF RightWheel_F.PowerOn = TRUE THEN
				RightWheel_F.Home := TRUE;
				IF RightWheel_F.IsHomed = TRUE THEN
					RightWheel_F.MoveVelocity := TRUE;
				END_IF
			END_IF
		END_IF
		IF RightWheel_B.Info.ReadyToPowerOn = TRUE THEN
			RightWheel_B.Power := TRUE;
			IF RightWheel_B.PowerOn = TRUE THEN
				RightWheel_B.Home := TRUE;
				IF RightWheel_B.IsHomed = TRUE THEN
					RightWheel_B.MoveVelocity := TRUE;
				END_IF
			END_IF
		END_IF
		
	ELSIF Proximity_1 = 0 AND Row = 1 THEN
		IF LeftWheel_F.Info.ReadyToPowerOn = TRUE THEN
			LeftWheel_F.Power := TRUE;
			IF LeftWheel_F.PowerOn = TRUE THEN
				LeftWheel_F.Home := TRUE;
				IF LeftWheel_F.IsHomed = TRUE THEN
					LeftWheel_F.MoveVelocity := TRUE;
				END_IF
			END_IF
			END_IF
		IF LeftWheel_B.Info.ReadyToPowerOn = TRUE THEN
			LeftWheel_B.Power := TRUE;
			IF LeftWheel_B.PowerOn = TRUE THEN
				LeftWheel_B.Home := TRUE;
				IF LeftWheel_B.IsHomed = TRUE THEN
					LeftWheel_B.MoveVelocity := TRUE;
				END_IF
			END_IF
		END_IF
		
		IF RightWheel_F.Info.ReadyToPowerOn = TRUE THEN
			RightWheel_F.Power := TRUE;
			IF RightWheel_F.PowerOn = TRUE THEN
				RightWheel_F.Home := TRUE;
				IF RightWheel_F.IsHomed = TRUE THEN
					RightWheel_F.MoveVelocity := TRUE;
				END_IF
			END_IF
		END_IF
		IF RightWheel_B.Info.ReadyToPowerOn = TRUE THEN
			RightWheel_B.Power := TRUE;
			IF RightWheel_B.PowerOn = TRUE THEN
				RightWheel_B.Home := TRUE;
				IF RightWheel_B.IsHomed = TRUE THEN
					RightWheel_B.MoveVelocity := TRUE;
				END_IF
			END_IF
		END_IF
		
	END_IF
	State := Proximity_1;
	ELSIF Start = FALSE OR Counter=totallane THEN
		Start:=FALSE;
		Counter:=0;
	IF LeftWheel_F.Info.ReadyToPowerOn = TRUE THEN
		LeftWheel_F.Power := FALSE;
		IF LeftWheel_F.PowerOn = TRUE THEN
			LeftWheel_F.Home := FALSE;
			IF LeftWheel_F.IsHomed = TRUE THEN
				LeftWheel_F.MoveVelocity := FALSE;
			END_IF
		END_IF
	END_IF
	IF LeftWheel_B.Info.ReadyToPowerOn = TRUE THEN
		LeftWheel_B.Power := FALSE;
		IF LeftWheel_B.PowerOn = TRUE THEN
			LeftWheel_B.Home := FALSE;
			IF LeftWheel_B.IsHomed = TRUE THEN
				LeftWheel_B.MoveVelocity := FALSE;
			END_IF
		END_IF
	END_IF
	IF RightWheel_F.Info.ReadyToPowerOn = TRUE THEN
		RightWheel_F.Power := FALSE;
		IF RightWheel_F.PowerOn = TRUE THEN
			RightWheel_F.Home := FALSE;
			IF RightWheel_F.IsHomed = TRUE THEN
				RightWheel_F.MoveVelocity := FALSE;
			END_IF
		END_IF
	END_IF
	IF RightWheel_B.Info.ReadyToPowerOn = TRUE THEN
		RightWheel_B.Power := FALSE;
		IF RightWheel_B.PowerOn = TRUE THEN
			RightWheel_B.Home := FALSE;
			IF RightWheel_B.IsHomed = TRUE THEN
				RightWheel_B.MoveVelocity := FALSE;
			END_IF
		END_IF
	END_IF
	END_IF
	////////////////////////////////////////////////////////////////////////////Left Sensor////////////////////////////////////////////////////////////////////////////////////////////////////
	IF Right_Proximity = 1 THEN
		Right_Solenoid := FALSE;
		RightAct := TRUE;
	ELSE
		//Rotate inside
		Right_Solenoid := TRUE;
		RightAct := FALSE;
	END_IF
		
	////////////////////////////////////////////////////////////////////////////Right Sensor////////////////////////////////////////////////////////////////////////////////////////////////////
	IF Left_Proximity = 1 THEN
		Left_Solenoid := FALSE;
		LeftAct := TRUE;
	ELSE
		//Rotate inside
		Left_Solenoid := TRUE;
		LeftAct := FALSE;
	END_IF
	
	/////////////////////////////////////////////////////////////////////////////Floatsensor value Float1 Float2//////////////////////////////////////////////////////////////////////////////////////////
	MpAlarmXCore_0.Enable := TRUE;
	MpAlarmXCore_0.MpLink := ADR(gAlarmXCore);
	MpAlarmXCore_0();
	
	MpAlarmXListUI_0.Enable:=TRUE;
	MpAlarmXListUI_0.MpLink:=ADR(gAlarmXCore);
	MpAlarmXListUI_0.UIConnect:=ADR(UIConnect);
	MpAlarmXListUI_0();
	////////////////////////////////////////////////////////////////////////////AlarmHistory/////////////////////////////////////////////////////////////////////////////////////////////////////
	MpAlarmXHistory_0.Enable := TRUE;
	MpAlarmXHistory_0.DeviceName := ADR('CF');
	MpAlarmXHistory_0.MpLink := ADR(gAlarmXHistory);
	MpAlarmXHistory_0();
	
	MpAlarmXHistoryUI_0.Enable :=TRUE;
	MpAlarmXHistoryUI_0.MpLink := ADR(gAlarmXHistory);
	MpAlarmXHistoryUI_0.UIConnect := ADR(UIConnectHistory);
	MpAlarmXHistoryUI_0();

	//MpAlarmXHistoryUI_0(MpLink :=ADR(gAlarmXHistory) , Enable := TRUE, ErrorReset := TRUE,UIConnect :=ADR(AlarmXHistoryUIConnect) );
	////////////////////////////////////////////////////////////////////////////Robot Identification/////////////////////////////////////////////////////////////////////////////////////////////
	IF KEY = TRUE THEN
		Buzzer := TRUE;
	ELSE
		Buzzer := FALSE;
	END_IF
	Battery;
	Float;
	
	/////////////////////////////////////////////////////////////////////////////Function call////////////////////////////////////////////////////////////////////////////////////////////////
	LeftWheel_F();
	LeftWheel_B();
	RightWheel_F();	
	RightWheel_B();
	TOF_0();
	MpAlarmXCore_0();
END_PROGRAM

PROGRAM _EXIT

END_PROGRAM