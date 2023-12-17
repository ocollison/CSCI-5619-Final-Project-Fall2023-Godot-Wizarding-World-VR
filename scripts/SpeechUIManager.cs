using Godot;
using System;
using System.Text.RegularExpressions;

public partial class SpeechUIManager : Node
{
	[Export] Button StartListeningButton;
	[Export] Label partialResultText;
	[Export] Label finalResultText;
	[Export] SpeechRecognizer speechRecognizer;
	[Signal]
	public delegate void SpellCastEventHandler(string newSpell);
	private string partialResult;
	private string finalResult;
	private string spell = "null";

	public override void _Ready()
	{
		StartListeningButton.Pressed += () =>
		{
			if (!speechRecognizer.isCurrentlyListening())
			{
				partialResultText.Text = "";
				finalResultText.Text = "";
				OnStartSpeechRecognition();
				speechRecognizer.StartSpeechRecognition();
			}
			else
			{
				OnStopSpeechRecognition();
				finalResult = speechRecognizer.StopSpeechRecoginition();
			}
		};

		speechRecognizer.OnPartialResult += (partialResult) =>
		{
			partialResultText.Text = partialResult;
		};
		speechRecognizer.OnFinalResult += (finalResult) =>
		{
			string final = ExtractText(finalResult);
			finalResultText.Text = final;
			OnStopSpeechRecognition();
		};
	}

	public override void _Process(double delta)
	{
	}

	private void OnStopSpeechRecognition()
	{
		StartListeningButton.Text = "Start Recognition";
		StartListeningButton.Modulate = new Color(1, 1, 1, 1f);
	}


	private void OnStartSpeechRecognition()
	{
		StartListeningButton.Text = "Stop Recognition";
		StartListeningButton.Modulate = new Color(1f, 0.5f, 0.5f, 1f);
	}
	
	string ExtractText(string jsonText) 
	{
		// Use regular expression to match text between quotes
		Regex regex = new Regex(@"""text"" *: *""([^""]*)""");
		Match match = regex.Match(jsonText);

		// Return the matched text 
		 return match.Groups[1].Value; 
	}
	private void _on_speech_recognizer_on_final_result(string finalResults)
	{
		string[] specialWords = {"fire", "lighting", "teleport", "shoot", "grab"};
		
		foreach (string word in specialWords)
		{
			if (finalResults.Contains(word)) 
			{
				spell = word;
				//GD.Print(spell);
				//EmitSignal(nameof(SpellCast), wor);
				//CallDeferred("emit_signal", "SpellCast");
				return;
			}
		}
		//GD.Print("No special ability found in string");
	}
	public string Spell
	{
		get { return spell; }
	}
}

