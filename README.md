# VK Engineers - Construction Company Website

A modern construction company website built with Eleventy static site generator.

## 🚀 Quick Start

```bash
# Install dependencies
npm install

# Start development (auto-reload)
npm run dev
# → Opens http://localhost:8189

# Test production build
npm start

# Build for deployment
npm run build

# Deploy to S3
./deploy-to-s3.sh your-bucket-name
```

## 📁 Project Structure

```
site/
├── src/              ← EDIT FILES HERE
│   ├── _layouts/
│   │   └── base.njk  ← Header & Footer (shared across all pages)
│   ├── index.html    ← Home page
│   ├── about.html    ← About Us
│   ├── service.html  ← Services
│   ├── team.html     ← Our Team
│   ├── portfolio.html ← Projects
│   ├── blog.html     ← Blog listing
│   ├── single.html   ← Blog post
│   ├── contact.html  ← Contact form
│   ├── css/, js/, img/, lib/
│
└── public/           ← AUTO-GENERATED (upload to S3)
```

**Important:** 
- ✅ Edit files in `src/`
- ❌ Never edit `public/` (gets overwritten on build)

## 📝 Available Commands

| Command | What It Does |
|---------|--------------|
| `npm run dev` | Development server with live reload (port 8189) ⭐ |
| `npm start` | Build + serve production preview |
| `npm run build` | Build site to `public/` folder |
| `npm run serve:public` | Serve built `public/` folder |
| `npm run clean` | Delete `public/` folder |

## 🎨 How Eleventy Works

### No More Duplicated Header/Footer!

**Before Eleventy:** Every page had duplicate header/footer code  
**With Eleventy:** Header/footer defined once in `src/_layouts/base.njk`

### Page Structure

Each page has front matter + content:

```html
---
layout: base.njk
title: Page Title
---

<!-- Your page content here -->
<div class="page-header">
    <h2>Your Content</h2>
</div>
```

The layout wraps your content with header/footer automatically.

## ✏️ Common Tasks

### Edit Header or Footer
1. Edit `src/_layouts/base.njk`
2. Run `npm run build`
3. All pages update automatically!

### Add a New Page
1. Create `src/services.html`:
   ```html
   ---
   layout: base.njk
   title: Our Services
   ---
   
   <div class="page-header">
       <h2>Services</h2>
   </div>
   <!-- your content -->
   ```
2. Build: `npm run build`
3. Output: `public/services/index.html`

### Update Styles or Scripts
1. Edit `src/css/style.css` or `src/js/main.js`
2. Changes auto-reload if using `npm run dev`

## 🌐 Deploy to AWS S3

### Quick Deploy
```bash
./deploy-to-s3.sh your-bucket-name
```

### Manual Deploy
```bash
# 1. Build
npm run build

# 2. Upload to S3
aws s3 sync public/ s3://your-bucket-name/ --delete

# 3. Enable static hosting (first time only)
aws s3 website s3://your-bucket-name/ \
  --index-document index.html
```

### Make Bucket Public (first time only)
Create `bucket-policy.json`:
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadGetObject",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::your-bucket-name/*"
  }]
}
```

Apply:
```bash
aws s3api put-bucket-policy --bucket your-bucket-name --policy file://bucket-policy.json
```

Your site: `http://your-bucket-name.s3-website-[region].amazonaws.com`

## 🔄 Typical Workflow

### Daily Development
```bash
npm run dev
# Edit files in src/
# Browser auto-refreshes
```

### Before Deployment
```bash
npm start
# Test at http://localhost:8189
# Verify everything works
```

### Deploy
```bash
./deploy-to-s3.sh your-bucket-name
```

## 🐛 Troubleshooting

**Changes not showing?**
```bash
npm run clean && npm run dev
```

**Port already in use?**
```bash
lsof -ti:8189 | xargs kill -9
npm run dev
```

**Build errors?**
```bash
npm run clean
npm install
npm run build
```

## 📚 Technologies Used

- **Eleventy** - Static site generator
- **Nunjucks** - Templating engine
- **Bootstrap 4** - CSS framework
- **jQuery** - JavaScript library
- Various plugins: Owl Carousel, WOW.js, Lightbox, etc.

## 💡 Tips

- Edit in `src/`, never in `public/`
- Use `npm run dev` for daily work
- Test with `npm start` before deploying
- Run `npm run clean` if builds seem stuck
- All asset paths should start with `/` (e.g., `/img/logo.png`)

## 🎯 Converting Existing HTML Pages

To convert a page from the original template:

1. Open the original HTML file
2. Remove everything from start to `<!-- Nav Bar End -->`
3. Remove everything from `<!-- Footer Start -->` to end
4. Add front matter at the top:
   ```yaml
   ---
   layout: base.njk
   title: Page Title
   ---
   ```
5. Update image paths to start with `/` (e.g., `img/about.jpg` → `/img/about.jpg`)
6. Save to `src/` directory
7. Run `npm run build`

## 📖 Learn More

- [Eleventy Documentation](https://www.11ty.dev/docs/)
- [Nunjucks Templating](https://mozilla.github.io/nunjucks/)
- [AWS S3 Static Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)

## 📄 License

See [LICENSE.txt](./LICENSE.txt)

---

**Need help?** Check the comments in `.eleventy.js` or `src/_layouts/base.njk`
