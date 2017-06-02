# Image-URL-Loader

This file is written in Swift 3.0 and works with Xcode 8.0+
The ImageLoader will asynchronously load the image from the internet and save to cahce so that it need not be downloaded again. The loader has a protocol `ImageLoaderProtocol` that your controller needs to conforn to.

### Installation

You can just drag and drop the file into your project and use it.

To use in cell for row at index path:

```sh
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! CustomTableViewCell
            if let image = ImageLoader.cache.object(forKey: tweet.imageUrl as AnyObject) as? Data{
                let cachedImage = UIImage(data: image)
                cell.profileImageView.image = cachedImage
            } else {
                let imageLoader = ImageLoader(delegate: self, indexPath: indexPath)
                imageLoader.imageFromUrl(urlString: tweet.imageUrl)
                cell.profileImageView.image = UIImage(named: "placeholder")
            }
      return cell
 }
```


Using the Delegate Method:

```sh
func imageLoaded(image: UIImage, forIndexPath indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
            cell.profileImageView.image = image
        }
    }
```
