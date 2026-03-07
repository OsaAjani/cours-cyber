<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>JWT Role Demo (Node)</title>
    <style>
      body { font-family: system-ui, -apple-system, Arial; padding: 2rem; background:#fafafa; }
      .card { border: 1px solid #ddd; padding: 1rem; border-radius: 8px; max-width: 720px; background:white; margin: 0 auto; }
      pre { background:#f6f6f6; padding:0.5rem; overflow:auto; }
      button { padding: 0.5rem 1rem; margin-right:0.5rem; }
      .note { font-size:0.9rem; color:#444; }
    </style>
  </head>
  <body>
    <div class="card">
      
      <h1>JWT Role Demo (Node)</h1>
  <p class="note">Educational demo — demonstrates parsing/verification flow. Run locally only.</p>

  <div>
    <button id="showtoken">Show token cookie</button>
    <button id="check" onclick="window.location.reload()">Check token now</button>
  </div>

  <p>Role: <strong id="role"><?= $role ?></strong></p>
  <p id="result">

    <?php if ($role != 'hacker'): ?>
      Your are a <?= $role; ?>. Try changing your role to <code>hacker</code> in the token cookie!
    <?php else: ?>
      🎉 Congratulations! You have successfully changed your role to <code>hacker</code>
    <?php endif; ?>

  </p>

  <script src="./script.js"></script>
    </div>
  </body>
</html>