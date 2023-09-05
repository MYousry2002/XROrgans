using UnityEngine;

public class OpenURLButton : MonoBehaviour
{
    public string url = "http://example.com"; // The URL to open, set in the Inspector

    // This function will be called from the button's OnClick event
    public void OpenURL()
    {
        // Open the URL specified in the Inspector
        Application.OpenURL(url);
    }
}