import { useState } from 'react';

enum Choice {
  Rock = 'グー',
  Paper = 'パー',
  Scissors = 'チョキ'
}

function getComputerChoice(): Choice {
  const choices = [Choice.Rock, Choice.Paper, Choice.Scissors];
  const randomIndex = Math.floor(Math.random() * choices.length);
  return choices[randomIndex];
}

function determineWinner(playerChoice: Choice, computerChoice: Choice): string {
  if (playerChoice === computerChoice) {
    return 'あいこです！';
  } else if (
    (playerChoice === Choice.Rock && computerChoice === Choice.Scissors) ||
    (playerChoice === Choice.Paper && computerChoice === Choice.Rock) ||
    (playerChoice === Choice.Scissors && computerChoice === Choice.Paper)
  ) {
    return 'あなたの勝ちです！';
  } else {
    return 'あなたの負けです！';
  }
}

function App() {
  const [result, setResult] = useState('');
  
  function playGame(playerChoice: Choice) {
    const computerChoice = getComputerChoice();
    const gameResult = determineWinner(playerChoice, computerChoice);
    setResult(`あなた: ${playerChoice}\nコンピュータ: ${computerChoice}\n${gameResult}`);
  }

  return (
    <div style={{ textAlign: 'center', marginTop: '50px' }}>
      <h1>じゃんけんゲーム</h1>
      <button onClick={() => playGame(Choice.Rock)}>グー</button>
      <button onClick={() => playGame(Choice.Paper)}>パー</button>
      <button onClick={() => playGame(Choice.Scissors)}>チョキ</button>
      <p style={{ whiteSpace: 'pre-wrap', marginTop: '20px', fontSize: '18px' }}>{result}</p>
    </div>
  );
}

export default App;
