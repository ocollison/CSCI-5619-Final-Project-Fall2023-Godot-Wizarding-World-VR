using Godot;
using System;
using System.Text.RegularExpressions;

public partial class SpeechUIManager : Node
{
	[Export] Button StartListeningButton;
	[Export] Label partialResultText;
	[Export] Label finalResultText;
	[Export] SpeechRecognizer speechRecognizer;

	private string partialResult;
	private string finalResult;

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
			finalResultText.Text = finalResult;
			OnStopSpeechRecognition();
			string final = ExtractText(finalResult);
			GD.Print(final);
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
}
