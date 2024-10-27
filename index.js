#!/usr/bin/env node

import { launch } from 'puppeteer-extra';
import { setTimeout } from "node:timers/promises";











async function why () {
  function reload(selector) {
    setTimeout(1000);
    if (!(page.$(selector))) {
      page.reload()
      setTimeout(1000)
    }
  }



  const browser = await launch({
    headless: false 
  });
   const context = await browser.createBrowserContext({incognito: true});
   const page = await context.newPage();
   
  
   await page.goto(`https://app.blackbaud.com/signin/?`);


    
    await page.waitForSelector('[icon = "google"]')
    
    await page.click('[icon = "google"]')
    await page.waitForSelector('[type = "email"]')
    
    


   
    
   
    
    await page.type('[type = "email"]', email)
    await page.click('[id = "identifierNext"]')
   await page.waitForSelector('[type = "password"]', {visible: true})
   await page.type('[type="password"]', password);
   await page.waitForSelector('#passwordNext');
   await page.click("#passwordNext");
   await page.waitForNavigation();
   await page.waitForSelector('[eventbuttonname = "Portal link"]')
   await page.click('[eventbuttonname="Portal link"]')
   
   await page.waitForNavigation();
   
   await page.waitForSelector('.cal-event')
   await page.click('[icon = "list"]')
   // ok finally at blackbaud home page!! now trying to get info stuff

   let hw = await page.evaluate(() => {
   const hws = document.getElementsByClassName('middle-block');
   const statusList = document.getElementsByClassName('right-block');
    
   
    let hw =  {
      "assignments": Array.from(hws).map(hws => {
        
        
      x = {
            name: hws.children[0].children[0].children[0].innerHTML.replace(/<[^>]*>/g, '').replace(/&[^;]*;/g, ''),
            dueDate: hws.children[1].textContent.trim().split('|')[0].trim().split(':')[1].split(' ')[1],
            Class: hws.children[1].textContent.trim().split('|')[2].split('-')[0].split(' (')[0].trim(),
            status: (hws.parentElement.children[2].textContent.trim().replace(/<[\>]*/g, '') == "In progress" || hws.parentElement.children[2].textContent.trim().replace(/<[\>]*/g, '') == "To do")? "To do" : hws.parentElement.children[2].textContent.trim().replace(/<[\>]*/g, '')
            
            
       }
       
       return x;
    })
    
   };
   console.log(hw);
   return hw;
   
});


//NOW trying to get the status of those classes

//browser.close();
return hw;


};





(async () => {
  
    let hw = await why()
    
   
   let path = (os.homedir() + '/.assignments.json');
   
   
   fs.writeFile(path, JSON.stringify(hw), (err) => {
      if (err) {
          
          console.error(`Error writing file to path: ${path}`);
          throw new Error(`${err.message} at path: ${path}`);
      }
      console.log(`The file has been saved at ${path}`);
  });

})();





























