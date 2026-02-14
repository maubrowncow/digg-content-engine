import { readFileSync } from 'fs';

const filePath = process.argv[2];
if (!filePath) {
  console.error('Usage: node clean-post.mjs <filepath>');
  process.exit(1);
}

let text = readFileSync(filePath, 'utf8');

// Remove invisible characters
text = text.replace(/\u00A0/g, ' ');  // Non-breaking space
text = text.replace(/\u200B/g, '');   // Zero-width space
text = text.replace(/\u200C/g, '');   // Zero-width non-joiner
text = text.replace(/\u200D/g, '');   // Zero-width joiner
text = text.replace(/\uFEFF/g, '');   // BOM

// Normalize line endings to LF
text = text.replace(/\r\n/g, '\n');
text = text.replace(/\r/g, '\n');

// Extract body between ``` markers after ## BODY
const bodyMatch = text.match(/## BODY\s*```\s*([\s\S]+?)```/);
if (bodyMatch) {
  console.log('=== CLEAN BODY ===\n');
  console.log(bodyMatch[1].trim());
} else {
  console.log(text);
}
