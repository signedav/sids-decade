# "Sid's Decade" aka "Dave's Thirties" aka "The Hochwind Years"

![sidhochwind](assets/sidhochwind-title.png)

## To do's 

- [ ] Make all the pictures
- [ ] Setup CI doing...
- [ ] ... download images
- [ ] ... create HTMLS (one per year)
- [ ] ... export as PDF

## Notes

### Get the pictures
```bash
pip3 install instaloader
```

```bash
instaloader profile sidhochwind
```

### CSS Stuff

```

/* Default styles */

h1 {
   color: #fff;
   background: url(banner.jpg);
}

@media print {
   h1 {
      color: #000;
      background: none;
   }

   nav, aside {
      display: none;
   }
}

```
